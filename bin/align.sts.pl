#!/share/app/perl-5.22.0/bin/perl -w
=head1 Name
    RNA/align.sts.pl
Info
    Author: Yuan-SW-F, yuanswf@163.com
    Created Time: 2016-08-23 11:13:57
Usage
    align.sts.pl	
=cut
use strict;
use feature qw(say);
use MCpath;
use MCsub;
use Getopt::Long;
my ($help);
GetOptions(
	"help!"=>\$help
);
die opth() if $help;

my %left;my %right;
for (@ARGV){
        open IN,$_;
        while (<IN>){
        if (/Left/){
                while (<IN>){
                /(\S+)\s*\:\s+(\d+)/;
                last if /Right/;
                $left{$1}+=$2;
                }
                while (<IN>){
        last if /overall/;
                /(\S+)\s*\:\s+(\d+)/;
        $right{$1}+=$2;
        }
        }
}
}
say "\t\tLeft reads\t\tRight reads\t";
say "Total reads number Mapped  Aligned 1 time  Aligned >1 times        Total reads number      Mapped  Aligned 1 time  Aligned >1 times
Overall mapping rate";
$left{align}=$left{Mapped}-$left{these};
say sprintf "$left{Input}\t$left{Mapped}\t".($left{Mapped}-$left{these})."\t$left{these}"."\t$right{Input}\t$right{Mapped}\t".($right{Mapped}-$right{these})."\t$right{these}\t%.2f",($left{Mapped}+$right{Mapped})/($left{Input}+$right{Input})*100;

