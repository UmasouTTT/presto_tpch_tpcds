#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;
use File::Path;
use List::Util;

open(VARADA_LOG, ">varada.log") or die "can not open varada.log";
open(HIVE_LOG, ">hive.log") or die "can not open hive.log";

# GLOBALS
my $SCRIPT_NAME = basename( __FILE__ );
my $SCRIPT_PATH = dirname( __FILE__ );

# test varada warm

chdir $SCRIPT_PATH;
chdir 'mix_varada';
my @queries = glob '*.sql';

# warm
print "***************************************Varada Warm**************************************************\n"
@queries = List::Util::shuffle @queries;
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";

	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query) | tee  ../tpch_logs/$warn_logfile > /dev/null";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print VARADA_LOG "$query,0 : $warmTime\n";

} # end for

# turn one
print "***************************************Varada Turn One**************************************************\n"
@queries = List::Util::shuffle @queries;
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";

	print "Turn one : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query) | tee  ../tpch_logs/$warn_logfile > /dev/null";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print VARADA_LOG "$query,1 : $warmTime\n";

} # end for

# turn two
print "***************************************Varada Turn Two**************************************************\n"
@queries = List::Util::shuffle @queries;
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";

	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query) | tee  ../tpch_logs/$warn_logfile > /dev/null";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print VARADA_LOG "$query,2 : $warmTime\n";

} # end for

close VARADA_LOG;

# test hive
print "***************************************Hive Warm**************************************************\n"
chdir $SCRIPT_PATH;
chdir 'mix_hive';
@queries = glob '*.sql';
@queries = List::Util::shuffle @queries;
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";

	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog hive -f ./$query) | tee  ../tpch_logs/$warn_logfile > /dev/null";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print HIVE_LOG "$query,0 : $warmTime\n";

} # end for

close HIVE_LOG;