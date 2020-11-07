#!/usr/bin/perl -w
=head1 Name
    /home/st_agric/lib/perl.pl
Info
    Version pipline-1.2.0
    Author: st_agric (FuYuan), fuyuan@genomics.cn
    Created Time: 2018-06-27 11:32:36
    Created Version: perl.pl
Usage
    perl.pl	
=cut
use strict;
use feature qw(say);
use lib '/home/st_agric/lib';
use test;
use Getopt::Long;
my ($help);
GetOptions(
	"help!"=>\$help
);
die opth() if $help;

my $pipath=path("pipline-1.2.0"); #$pipath/script/config.txt
say $pipath;
######################### Sub Routines #########################
