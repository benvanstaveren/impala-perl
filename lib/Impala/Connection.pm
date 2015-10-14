use strict;
use warnings;
package
    Impala::Connection;

use Mojo::Base '-base';
use Impala::Protocol;
use Impala::Cursor;
use boolean;
use Mojo::Exception;

use Thrift;
use Thrift::Socket;
use Thrift::BinaryProtocol;
use Thrift::BufferedTransport;

has 'host'      =>  undef;
has 'port'      =>  undef;
has 'connected' =>  sub { false };

has 'log_context_id'    =>  'impala-perl';

has 'transport' =>  undef;
has 'service'   =>  undef;

sub open {
    my $self = shift;

    return if $self->connected;

    my $socket = Thrift::Socket->new($self->host, $self->port);
    my $transport = Thrift::BufferedTransport->new($socket);

    $self->transport($transport);

    my $proto = Thrift::BinaryProtocol->new($self->transport);
    my $service = Impala::Protocol->new($proto);

    $self->service($service);

    $self->transport->open;

    $self->connected(true);
}

sub close {
    my $self = shift;

    return unless $self->connected;

    $self->transport->close;
    $self->connected(false);
}

sub refresh {
    my $self = shift;

    Mojo::Exception->throw('Connection is closed') unless $self->connected;
    $self->service->ResetCatalog();
}

sub query {
    my $self = shift;
    my $raw_query = shift;
    my $query_options = shift || {};

    return $self->execute($raw_query, $query_options)->fetch_all;
}

sub execute {
    my $self = shift;
    my $raw_query = shift;
    my $query_options = shift || {};

    Mojo::Exception->throw('Connection is closed') unless $self->connected;

    my $query = $self->_sanitize_query($raw_query);
    my $handle = $self->_send_query($query, $query_options);

    my $state = $self->service->get_state($handle);
    if($state == Impala::Protocol::Beeswax::Constants->EXCEPTION) {
        $self->service->close($handle);
        Mojo::Exception->throw('Query was aborted');
    }

    return Impala::Cursor->new($handle, $self->service);
}

sub _sanitize_query {
    my $self = shift;
    my $raw_query = shift;
    my @words = split(/\s+/, $raw_query);

    Mojo::Exception->throw('Empty query?') unless scalar(@words) > 0;

    my $command = lc(shift(@words));
    return join(' ', $command, @words);
}

sub _send_query {
    my $self = shift;
    my $sanitized_query = shift;
    my $query_opts = shift;

    my $query = Impala::Protocol::Beeswax::Query->new;

    $query->query($sanitized_query);
    $query->hadoop_user(delete($query_opts->{hadoop_user})) if(defined($query_opts->{hadoop_user}));
    $query->configuration([ map { sprintf('#%s=#%s', uc($_), $query_opts->{$_}) } (keys(%$query_opts)) ]);
    
    $self->service->executeAndWait($query, $self->log_context_id);
}

1;
