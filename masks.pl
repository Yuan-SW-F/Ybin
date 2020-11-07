#!/share/app/perl-5.22.0/bin/perl -w
=head1 Name
    tem_prog/masks.pl
Info
    Author: Yuan-SW-F, yuanswf@163.com
    Created Time: 2016-10-13 10:10:53
Usage
    masks.pl	
=cut
use strict;
use feature qw(say);
use MCpath;
use MCsub;
use Getopt::Long;
my ($fasta,$allgff,$help);
GetOptions(
	"fasta:s"=>\$fasta,
	"allgff:s"=>\$allgff,
	"help!"=>\$help
);
die opth() if $help;

my $argv=join "\t",@ARGV;
my $fa=$1 if $argv=~/(\S+\.fa)/;
my $gff=$1 if $argv=~/(\S+\.gff)/;

$fasta||=$fa;
$fasta||=$1 if `ls *fa`=~/(\S+\.fa)/;
$allgff||=$gff;
$allgff||=$1 if `ls *gff`=~/(\S+)/;
$allgff||="all.gff";
`ln -s $fasta` if $fasta=~/\//;
$fasta=$1 if $fasta=~/\/([^\/]+\.fa)$/;
my $fastanm=$1 if $fasta=~/(\w+)/;
say "CMD: $0 $fasta $allgff";
`cat $allgff|grep -v -P "Unknown|Simple_repeat|Low_complexity" > $fastanm\_known.gff`;
`cat $allgff|grep -P "Unknown|Simple_repeat|Low_complexity" > $fastanm\_Unknown.gff`;
`perl repeat_maksed_to_n.pl $fasta $fastanm\_known.gff > $fastanm\_hard.fa`;
`perl repeat_masked_to_lower_case.pl $fastanm\_hard.fa $fastanm\_Unknown.gff > $fastanm\_hardsoft.fa`;
