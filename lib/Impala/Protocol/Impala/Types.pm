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
	Impala::Protocol::Impala::TImpalaQueryOptions;
use constant ABORT_ON_ERROR => 0;
use constant MAX_ERRORS => 1;
use constant DISABLE_CODEGEN => 2;
use constant BATCH_SIZE => 3;
use constant MEM_LIMIT => 4;
use constant NUM_NODES => 5;
use constant MAX_SCAN_RANGE_LENGTH => 6;
use constant MAX_IO_BUFFERS => 7;
use constant NUM_SCANNER_THREADS => 8;
use constant ALLOW_UNSUPPORTED_FORMATS => 9;
use constant DEFAULT_ORDER_BY_LIMIT => 10;
use constant DEBUG_ACTION => 11;
use constant ABORT_ON_DEFAULT_LIMIT_EXCEEDED => 12;
use constant PARQUET_COMPRESSION_CODEC => 13;
use constant HBASE_CACHING => 14;
use constant HBASE_CACHE_BLOCKS => 15;
package
	Impala::Protocol::Impala::TInsertResult;
use base qw(Class::Accessor);
Impala::Protocol::Impala::TInsertResult->mk_accessors( qw( rows_appended ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{rows_appended} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{rows_appended}) {
      $self->{rows_appended} = $vals->{rows_appended};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'TInsertResult';
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
      /^1$/ && do{      if ($ftype == TType::MAP) {
        {
          my $_size0 = 0;
          $self->{rows_appended} = {};
          my $_ktype1 = 0;
          my $_vtype2 = 0;
          $xfer += $input->readMapBegin(\$_ktype1, \$_vtype2, \$_size0);
          for (my $_i4 = 0; $_i4 < $_size0; ++$_i4)
          {
            my $key5 = '';
            my $val6 = 0;
            $xfer += $input->readString(\$key5);
            $xfer += $input->readI64(\$val6);
            $self->{rows_appended}->{$key5} = $val6;
          }
          $xfer += $input->readMapEnd();
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
  $xfer += $output->writeStructBegin('TInsertResult');
  if (defined $self->{rows_appended}) {
    $xfer += $output->writeFieldBegin('rows_appended', TType::MAP, 1);
    {
      $xfer += $output->writeMapBegin(TType::STRING, TType::I64, scalar(keys %{$self->{rows_appended}}));
      {
        while( my ($kiter7,$viter8) = each %{$self->{rows_appended}}) 
        {
          $xfer += $output->writeString($kiter7);
          $xfer += $output->writeI64($viter8);
        }
      }
      $xfer += $output->writeMapEnd();
    }
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package
	Impala::Protocol::Impala::TPingImpalaServiceResp;
use base qw(Class::Accessor);
Impala::Protocol::Impala::TPingImpalaServiceResp->mk_accessors( qw( version ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{version} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{version}) {
      $self->{version} = $vals->{version};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'TPingImpalaServiceResp';
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
      /^1$/ && do{      if ($ftype == TType::STRING) {
        $xfer += $input->readString(\$self->{version});
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
  $xfer += $output->writeStructBegin('TPingImpalaServiceResp');
  if (defined $self->{version}) {
    $xfer += $output->writeFieldBegin('version', TType::STRING, 1);
    $xfer += $output->writeString($self->{version});
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

package
	Impala::Protocol::Impala::TResetTableReq;
use base qw(Class::Accessor);
Impala::Protocol::Impala::TResetTableReq->mk_accessors( qw( db_name table_name ) );

sub new {
  my $classname = shift;
  my $self      = {};
  my $vals      = shift || {};
  $self->{db_name} = undef;
  $self->{table_name} = undef;
  if (UNIVERSAL::isa($vals,'HASH')) {
    if (defined $vals->{db_name}) {
      $self->{db_name} = $vals->{db_name};
    }
    if (defined $vals->{table_name}) {
      $self->{table_name} = $vals->{table_name};
    }
  }
  return bless ($self, $classname);
}

sub getName {
  return 'TResetTableReq';
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
      /^1$/ && do{      if ($ftype == TType::STRING) {
        $xfer += $input->readString(\$self->{db_name});
      } else {
        $xfer += $input->skip($ftype);
      }
      last; };
      /^2$/ && do{      if ($ftype == TType::STRING) {
        $xfer += $input->readString(\$self->{table_name});
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
  $xfer += $output->writeStructBegin('TResetTableReq');
  if (defined $self->{db_name}) {
    $xfer += $output->writeFieldBegin('db_name', TType::STRING, 1);
    $xfer += $output->writeString($self->{db_name});
    $xfer += $output->writeFieldEnd();
  }
  if (defined $self->{table_name}) {
    $xfer += $output->writeFieldBegin('table_name', TType::STRING, 2);
    $xfer += $output->writeString($self->{table_name});
    $xfer += $output->writeFieldEnd();
  }
  $xfer += $output->writeFieldStop();
  $xfer += $output->writeStructEnd();
  return $xfer;
}

1;
