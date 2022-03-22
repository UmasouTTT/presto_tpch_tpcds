#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;
use File::Path;

open(LOG, ">tpcds.log") or die "can not open tpcds.log";

# GLOBALS
my $SCRIPT_NAME = basename( __FILE__ );
my $SCRIPT_PATH = dirname( __FILE__ );

chdir $SCRIPT_PATH;
chdir 'tpcds';
my @queries = glob '*.sql';



# warm
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";
	print "Warming Query : $query\n"; 
	my $warmStart = time();
	my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query) | tee  ../tpcds_logs/$warn_logfile > /dev/null";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print LOG "$query,0 : $warmTime\n";
	print "Warmed Query : $query In $warmTime secs\n"; 

} # end for

## run 1
#for my $query ( @queries ) {
#    my $warn_logfile = "$query.warn.log";
#    my $logname = "$query.log";
#	print "Running Query : $query\n";
#	my $runStart = time();
#	my $cmd2="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query) | tee  ../tpcds_logs/$logname > /dev/null";
#	my @runoutput=`$cmd2`;
#
#	my $runEnd = time();
#	my $runTime = $runEnd - $runStart ;
#	print LOG "$query,1 :  $runTime\n";
#	print "$query Done in  $runTime secs\n";
#
#} # end for
#
## run 2
#for my $query ( @queries ) {
#    my $warn_logfile = "$query.warn.log";
#    my $logname = "$query.log";
#	print "Running Query : $query\n";
#	my $runStart = time();
#	my $cmd2="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query) | tee  ../tpcds_logs/$logname > /dev/null";
#	my @runoutput=`$cmd2`;
#
#	my $runEnd = time();
#	my $runTime = $runEnd - $runStart ;
#	print LOG "$query,2 :  $runTime\n";
#	print "$query Done in  $runTime secs\n";
#} # end for

close LOG;