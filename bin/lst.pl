#!/usr/bin/perl -w
=head1 Info
    Script Name    :lst.pl
    Script Author  : Yuan-SW-F, yuanswf@163.com
    Created Time   : 2019-04-04 10:33:08
    Created Version: lst.pl
=cut
use strict;
use feature qw(say);
use Getopt::Long;
my ($help,$p,$a);
GetOptions(
	"a:s"=>\$a,
	"p:s"=>\$p,
	"help!"=>\&USAGE,)
or USAGE();
$a= $a ? "$a " : "";
my ($n,@i,$l);
$p||='\s+';
while (<STDIN>){
		if (/\n/){
				$n++;
				chomp;
				push @i,$_;
		}else{
				push @i,$_;
		}
}
if ($n<2){
		$l=$i[0];
		@i=split /$p/,$l;
		$l=join "\n$a",@i;
		print "$a$l\n";
}else{
		$l=join " ",@i;
		print "$l\n";
}
######################### Sub Routines #########################
sub USAGE{
my $uhead=`pod2text $0`;
my $usage=<<"USAGE";
USAGE:
	perl $0
	--help	output help information to screen
USAGE
print $uhead.$usage;
exit;}
