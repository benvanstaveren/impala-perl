#
# Autogenerated by Thrift Compiler (0.9.1)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#
require 5.6.0;
use strict;
use warnings;
use Thrift;

use Impala::Protocol::Impala::Types;
use Impala::Protocol::Hive::TCLIService;

# HELPER FUNCTIONS AND STRUCTURES

package
	Impala::Protocol::Impala::ImpalaHiveServer2ServiceIf;

use strict;
use base qw(Impala::Protocol::Hive::TCLIServiceIf);

package
	Impala::Protocol::Impala::ImpalaHiveServer2ServiceRest;

use strict;
use base qw(Impala::Protocol::Hive::TCLIServiceRest);

package
	Impala::Protocol::Impala::ImpalaHiveServer2ServiceClient;

use base qw(Impala::Protocol::Hive::TCLIServiceClient);
use base qw(Impala::Protocol::Impala::ImpalaHiveServer2ServiceIf);
sub new {
    my ($classname, $input, $output) = @_;
    my $self      = {};
    $self = $classname->SUPER::new($input, $output);
    return bless($self,$classname);
}

package
	Impala::Protocol::Impala::ImpalaHiveServer2ServiceProcessor;

use strict;
use base qw(Impala::Protocol::Hive::TCLIServiceProcessor);

sub process {
      my ($self, $input, $output) = @_;
      my $rseqid = 0;
      my $fname  = undef;
      my $mtype  = 0;

      $input->readMessageBegin(\$fname, \$mtype, \$rseqid);
      my $methodname = 'process_'.$fname;
      if (!$self->can($methodname)) {
        $input->skip(TType::STRUCT);
        $input->readMessageEnd();
        my $x = new TApplicationException('Function '.$fname.' not implemented.', TApplicationException::UNKNOWN_METHOD);
        $output->writeMessageBegin($fname, TMessageType::EXCEPTION, $rseqid);
        $x->write($output);
        $output->writeMessageEnd();
        $output->getTransport()->flush();
        return;
      }
      $self->$methodname($rseqid, $input, $output);
      return 1;
}

1;
