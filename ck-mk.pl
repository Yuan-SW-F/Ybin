#!/usr/bin/perl -w
=head1 Name
Info
    Author: Yuan-SW-F, yuanswf@163.com
    Created Time: 2016-12-30 10:22:07
    Created Version: check.pl
Usage
    check.pl	
=cut
use strict;
use feature qw(say);
use Getopt::Long;
my ($help);
GetOptions(
	"help!"=>\$help
);
die opth() if $help;

open F12,"finished.list";
my ($id,$seq,$len);
while (<F12>){
	`less $_`=~/cd\s+(\S+)\/([^\s\/\;]+)/;
	my $file=$1 if `ls $1/../*cut/$2` =~/(\S+)/;
	say $file;
	open F11,"$file";
	while (<F11>){
		$id=$1 if /\>?(\S+)/;
		$/="\>";
		$seq=<F11>;
		$seq=~s/\>$//;
		$seq=~s/\s//g;
		$len+=length($seq);
		$/="\n";
		}
	}
say $len;
