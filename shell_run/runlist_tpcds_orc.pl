#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;
use File::Path;
use List::Util;

# GLOBALS
my $SCRIPT_NAME = basename( __FILE__ );
my $SCRIPT_PATH = dirname( __FILE__ );

open(ORC_VARADA_LOG, ">orc_varada_tpcds.log") or die "can not open varada.log";
open(ORC_HIVE_LOG, ">orc_hive_tpcds.log") or die "can not open hive.log";



# test varada warm



print "*********************************ORC******************************************************";

# test hive
print "***************************************Hive Warm**************************************************\n";
chdir $SCRIPT_PATH;
chdir 'tpcds_hive_orc';
my @queries = glob '*.sql';
for my $query ( @queries ) {

	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog hive -f ./$query)";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print ORC_HIVE_LOG "$query,0 : $warmTime\n";

} # end for

print "***************************************Hive Turn One**************************************************\n";
for my $query ( @queries ) {

	print "Executing Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog hive -f ./$query)";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Executed Query : $query In $warmTime secs\n";
	print ORC_HIVE_LOG "$query,1 : $warmTime\n";

} # end for

close ORC_HIVE_LOG;

chdir "../";
chdir 'tpcds_varada_orc';
@queries = glob '*.sql';
#
## warm
print "***************************************Varada Warm**************************************************\n";
for my $query ( @queries ) {
	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print ORC_VARADA_LOG "$query,0 : $warmTime\n";


} # end for
#
# turn one
print "***************************************Varada Turn One**************************************************\n";
for my $query ( @queries ) {

	print "Turn one : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print ORC_VARADA_LOG "$query,1 : $warmTime\n";


} # end for
#
# turn two
print "***************************************Varada Turn Two**************************************************\n";
for my $query ( @queries ) {

	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print ORC_VARADA_LOG "$query,2 : $warmTime\n";


} # end for

print "***************************************Varada Turn Three**************************************************\n";
for my $query ( @queries ) {

	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print ORC_VARADA_LOG "$query,3 : $warmTime\n";


} # end for

print "***************************************Varada Turn Four**************************************************\n";
for my $query ( @queries ) {

	print "Warming Query : $query\n";
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print ORC_VARADA_LOG "$query,4 : $warmTime\n";


} # end for

close ORC_VARADA_LOG;
#
