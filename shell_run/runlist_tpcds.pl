#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;
use File::Path;
use List::Util;

# GLOBALS
my $SCRIPT_NAME = basename( __FILE__ );
my $SCRIPT_PATH = dirname( __FILE__ );

open(VARADA_LOG, ">varada_tpcds.log") or die "can not open varada.log";
open(HIVE_LOG, ">hive_tpcds.log") or die "can not open hive.log";

my @selected_queries = ( "q01.sql","q03.sql","q07.sql","q09.sql","q10.sql","q18.sql","q21.sql","q26.sql","q27.sql",
"q28.sql","q33.sql","q36.sql","q37.sql","q42.sql","q44.sql","q52.sql","q53.sql","q54.sql","q55.sql","q56.sql","q61.sql","q63.sql",
"q64.sql","q71.sql","q76.sql","q80.sql","q82.sql","q88.sql","q90.sql","q96.sql");

# test varada warm



print "****************************************parquet******************************************************";

print "***************************************Hive Warm**************************************************\n";
chdir $SCRIPT_PATH;
chdir 'tpcds_hive';
my @queries = glob '*.sql';
for my $query ( @queries ) {
    if(grep /^query/, @selected_queries ){
        print "Warming Query : $query\n";
        my $warmStart = time();
        my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog hive -f ./$query)";
        my @warnoutput=`$cmd`;

        my $warmEnd = time();
        my $warmTime = $warmEnd - $warmStart ;
        print "Warmed Query : $query In $warmTime secs\n";
        print HIVE_LOG "$query,0 : $warmTime\n";
    }

} # end for
for my $query ( @queries ) {
    if(grep /^query/, @selected_queries ){
        print "Executing Query : $query\n";
        my $warmStart = time();
        my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog hive -f ./$query)";
        my @warnoutput=`$cmd`;

        my $warmEnd = time();
        my $warmTime = $warmEnd - $warmStart ;
        print "Warmed Query : $query In $warmTime secs\n";
        print HIVE_LOG "$query,1 : $warmTime\n";
    }

} # end for
close HIVE_LOG;

## warm
print "***************************************Varada Warm**************************************************\n";
chdir '../';
chdir 'tpcds_varada';
my @queries = glob '*.sql';

for my $query ( @queries ) {
    if(grep /^query/, @selected_queries ){
        print "Warming Query : $query\n";
        my $warmStart = time();
        my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
        my @warnoutput=`$cmd`;

        my $warmEnd = time();
        my $warmTime = $warmEnd - $warmStart ;
        print "Warmed Query : $query In $warmTime secs\n";
        print VARADA_LOG "$query,0 : $warmTime\n";
        sleep 15;
    }

} # end for
#
# turn one
print "***************************************Varada Turn One**************************************************\n";
for my $query ( @queries ) {
    if(grep /^query/, @selected_queries ){
        print "Turn one : $query\n";
        my $warmStart = time();
        my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
        my @warnoutput=`$cmd`;

        my $warmEnd = time();
        my $warmTime = $warmEnd - $warmStart ;
        print "Warmed Query : $query In $warmTime secs\n";
        print VARADA_LOG "$query,1 : $warmTime\n";

        sleep 15;
    }

} # end for
#
# turn two
print "***************************************Varada Turn Two**************************************************\n";
for my $query ( @queries ) {
    if(grep /^query/, @selected_queries ){
        print "Warming Query : $query\n";
        my $warmStart = time();
        my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
        my @warnoutput=`$cmd`;

        my $warmEnd = time();
        my $warmTime = $warmEnd - $warmStart ;
        print "Warmed Query : $query In $warmTime secs\n";
        print VARADA_LOG "$query,2 : $warmTime\n";

        sleep 15;
    }

} # end for

print "***************************************Varada Turn Three**************************************************\n";
for my $query ( @queries ) {
    if(grep /^query/, @selected_queries ){
        print "Warming Query : $query\n";
        my $warmStart = time();
        my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
        my @warnoutput=`$cmd`;

        my $warmEnd = time();
        my $warmTime = $warmEnd - $warmStart ;
        print "Warmed Query : $query In $warmTime secs\n";
        print VARADA_LOG "$query,3 : $warmTime\n";

        sleep 15;
    }

} # end for

print "***************************************Varada Turn Four**************************************************\n";
for my $query ( @queries ) {
    if(grep /^query/, @selected_queries ){
        print "Warming Query : $query\n";
        my $warmStart = time();
        my $cmd="(/home/ec2-user/bigdata/trino/trino-server-370/bin/trino --server localhost:8080 --catalog varada -f ./$query)";
        my @warnoutput=`$cmd`;

        my $warmEnd = time();
        my $warmTime = $warmEnd - $warmStart ;
        print "Warmed Query : $query In $warmTime secs\n";
        print VARADA_LOG "$query,4 : $warmTime\n";

        sleep 15;
    }

} # end for

close VARADA_LOG;
#
# test hive





