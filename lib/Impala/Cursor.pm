use strict;
use warnings;
package
    Impala::Cursor;

use Mojo::Base '-base';
use boolean;
use Mojo::Exception;
use Try::Tiny qw/try catch/;

has 'handle'    =>  undef;
has 'service'   =>  undef;

has 'done'      =>  sub { false };
has 'open'      =>  sub { true };

has 'row_buffer'    =>  sub { [] };
has 'buffer_size'   =>  1024;
has 'metadata'      =>  sub {
    my $self = shift;

    return $self->service->get_results_metadata($self->handle);
};

sub new {
    my $package = shift;
    my $self    = $package->SUPER::new(@_);

    bless($self, $package);

    $self->fetch_more;
    return $self;
}

sub fetch_row {
    my $self = shift;

    if(scalar(@{$self->row_buffer}) == 0) {
        if($self->done) {
            return undef;
        } else {
            $self->fetch_more;
        }
    }

    return shift(@{$self->row_buffer});
}

sub close {
    my $self = shift;

    $self->open(false);
    $self->service->close($self->handle);
}

sub has_more {
    my $self = shift;

    return true if !$self->done; # there's more
    return false;
}

sub runtime_profile {
    my $self = shift;

    return $self->service->GetRuntimeProfile($self->handle);
}

sub fetch_more {
    my $self = shift;

    while(!$self->done && scalar(@{$self->row_buffer}) < $self->buffer_size) {
        $self->fetch_batch;
    }
}

sub fetch_batch {
    my $self = shift;

    Mojo::Exception->throw('Cursor has expired or has been closed') unless $self->open;

    my $res;

    try {
        $res = $self->service->fetch($self->handle, false, $self->buffer_size);
    } catch {
        $self->open(false);
        Mojo::Exception->throw('Cursor has expired or has been closed');
    };

    push(@{$self->row_buffer}, map { $self->parse_row } @{$res->data});

    unless($res->has_more) {
        $self->done(true);
        $self->close;
    }
}

sub parse_row {
    my $self = shift;

}

sub convert_raw_value {
    my $self = shift;

}

1; 
