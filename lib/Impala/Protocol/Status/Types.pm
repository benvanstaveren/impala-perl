#
# Autogenerated by Thrift Compiler (0.9.1)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#
require 5.6.0;
use strict;
use warnings;
use Thrift;

package
	Impala::Protocol::Status::TStatusCode;
use constant OK => 0;
use constant CANCELLED => 1;
use constant ANALYSIS_ERROR => 2;
use constant NOT_IMPLEMENTED_ERROR => 3;
use constant RUNTIME_ERROR => 4;
use constant MEM_LIMIT_EXCEEDED => 5;
use constant INTERNAL_ERROR => 6;
package
	Impala::Protocol::Status::TStatus;
use base qw(Class::Accessor);
Impala::Protocol::Status::TStatus->mk_accessors( qw( status_code error_msgs ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{status_code} = undef;
  $self->{error_msgs} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{status_code}) {
      $self->{status_code} = $vals->{status_code};
    }
    if (defined $vals->{error_msgs}) {
      $self->{error_msgs} = $vals->{error_msgs};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'TStatus';
}

sub read {
  my ($self, $input) = @_;
  my $xfer  = 0;
  my $fname;
  my $ftype = 0;
  my $fid   = 0;
  $xfer += $input->readStructBegin(\$fname);
  while (1) 
  {
    $xfer += $input->readFieldBegin(\$fname, \$ftype, \$fid);
    if ($ftype == TType::STOP) {
      last;
    }
    SWITCH: for($fid)
    {
      /^1$/ && do{      if ($ftype == TType::I32) {
        $xfer += $input->readI32(\$self->{status_code});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^2$/ && do{      if ($ftype == TType::LIST) {
        {
          my $_size0 = 0;
          $self->{error_msgs} = [];
          my $_etype3 = 0;
          $xfer += $input->readListBegin(\$_etype3, \$_size0);
          for (my $_i4 = 0; $_i4 < $_size0; ++$_i4)
          {
            my $elem5 = undef;
            $xfer += $input->readString(\$elem5);
            push(@{$self->{error_msgs}},$elem5);
          }
          $xfer += $input->readListEnd();
        }
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
        $xfer += $input->skip($ftype);
    }
    $xfer += $input->readFieldEnd();
  }
  $xfer += $input->readStructEnd();
  return $xfer;
}

sub write {
  my ($self, $output) = @_;
  my $xfer   = 0;
  $xfer += $output->writeStructBegin('TStatus');
  if (defined $self->{status_code}) {
    $xfer += $output->writeFieldBegin('status_code', TType::I32, 1);
    $xfer += $output->writeI32($self->{status_code});
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{error_msgs}) {
    $xfer += $output->writeFieldBegin('error_msgs', TType::LIST, 2);
    {
      $xfer += $output->writeListBegin(TType::STRING, scalar(@{$self->{error_msgs}}));
      {
        foreach my $iter6 (@{$self->{error_msgs}}) 
        {
          $xfer += $output->writeString($iter6);
        }
      }
      $xfer += $output->writeListEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

1;
