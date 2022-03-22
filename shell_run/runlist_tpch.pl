#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;
use File::Path;

open(LOG, ">tpch.log") or die "can not open tpch.log";

# GLOBALS
my $SCRIPT_NAME = basename( __FILE__ );
my $SCRIPT_PATH = dirname( __FILE__ );

chdir $SCRIPT_PATH;
chdir 'tpch';
my @queries = glob '*.sql';


# warm
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";

	print "Warming Query : $query\n"; 
	my $warmStart = time();
	my $cmd="(/home/ec2-user/trino/trino/bin/trino --server localhost:8001 --catalog hive -f ./$query) | tee  ../tpch_logs/$warn_logfile > /dev/null";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n";
	print LOG "$query,0 : $warmTime\n";

} # end for

# turn 1
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";
	print "Running Query : $query\n";
	my $runStart = time();
	my $cmd2="(/home/ec2-user/trino/trino/bin/trino --server localhost:8001 --catalog hive -f ./$query) | tee  ../tpch_logs/$logname > /dev/null";
	my @runoutput=`$cmd2`;

	my $runEnd = time();
	my $runTime = $runEnd - $runStart ;
	print "$query Done in  $runTime secs\n";
	print LOG "$query,1:  $runTime\n";

} # end for

# turn 2
for my $query ( @queries ) {
    my $warn_logfile = "$query.warn.log";
    my $logname = "$query.log";
    # turn 1
	print "Running Query : $query\n";
	my $runStart = time();
	my $cmd2="(/home/ec2-user/trino/trino/bin/trino --server localhost:8001 --catalog hive -f ./$query) | tee  ../tpch_logs/$logname > /dev/null";
	my @runoutput=`$cmd2`;

	my $runEnd = time();
	my $runTime = $runEnd - $runStart ;
	print "$query Done in  $runTime secs\n";
	print LOG "$query,2:  $runTime\n";

} # end for

close LOG;