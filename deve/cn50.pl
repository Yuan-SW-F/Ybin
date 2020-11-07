#!/usr/bin/perl -w
=head1 Name
Info
    Author: Yuan-SW-F, yuanswf@163.com
    Created Time: 2017-02-06 09:56:32
    Created Version: cn50.pl
Changed from :
    lit_program/cn50.pl
Info
    Author: Yuan-SW-F, yuanswf@163.com
    Created Time: 2016-08-17 11:19:28
Usage
    cn50.pl	
=cut
use strict;
use feature qw(say);
use MCsub;
use Getopt::Long;
my ($cut_off,$help,$check);
GetOptions(
	"check!"=>\$check,
	"cutoff:i"=>\$cut_off,
	"help!"=>\$help
);
$cut_off||=100;
die opth() if $help;

for (@ARGV){
	my ($s,$nl100,$nl2000,@l,$tl,$cnl100,$cnl2000,@cl,$ctl,@cc,@out);
	my $l=0;
	my $output="$1.n50" if /(\S+)/;
	open IN,$_||$!;
	while (<IN>){
	chomp;
		if (/^\>/){
		$nl100++ if $l>=100;
		$nl2000++ if $l>=2000;
			if ($l>=$cut_off){
			push @l,$l;
			$tl+=$l;
				$s=~s/\s+//g;
				@cc=split /[N,n]+/,$s;
				for (@cc){
					if (length($_)>=$cut_off){
					push @cl,length($_);
					$ctl+=length($_);
					$cnl100++ if length($_)>=100;
					$cnl2000++ if length($_)>=2000;
					}
				$s="";
				}
			}
		$l=0;
		}else{
		$s.=$_;
		$l+=length($_);
		}
	}
		$nl100++ if $l>=100;
		$nl2000++ if $l>=2000;
			if ($l>=$cut_off){
			push @l,$l;
			$tl+=$l;
				$s=~s/\s+//g;
				@cc=split /[N,n]+/,$s;
				for (@cc){
					if (length($_)>=$cut_off){
					push @cl,length($_);
					$ctl+=length($_);
					$cnl100++ if length($_)>=100;
					$cnl2000++ if length($_)>=2000;
					}
				}
			}
	close IN;
	@l=sort {$b<=>$a}@l;
	@cl=sort {$b<=>$a}@cl;
	push @out, "3.3 Summarized by N50\n\n";
	push @out, " \tScaffold\t\tScaftig\n";
	push @out, " \tLength(bp)\tNumber\tLength(bp)\tNumber\n";
	push @out, "Max_len\t$l[0]\t\t$cl[0]\n";
	my (%l50,$sum,%n50);
	my $n=10;
		for my $i(0..$#l){
		$sum+=$l[$i];
			if ($sum>=$tl*$n/100){
			$n50{$n}=$l[$i];
			$l50{$n}=$i+1;
			$n+=10;
			}
		last if $n==100;
	}
	my (%cl50,$csum,%cn50);
	$n=10;
		for my $i(0..$#cl){
		$csum+=$cl[$i];
			if ($csum>=$ctl*$n/100){
			$cn50{$n}=$cl[$i];
			$cl50{$n}=$i+1;
			$n+=10;
			}
		last if $n==100;
	}
	push @out, "N90\t$n50{90}\t$l50{90}\t$cn50{90}\t$cl50{90}\n";
	push @out, "N80\t$n50{80}\t$l50{80}\t$cn50{80}\t$cl50{80}\n";
	push @out, "N70\t$n50{70}\t$l50{70}\t$cn50{70}\t$cl50{70}\n";
	push @out, "N60\t$n50{60}\t$l50{60}\t$cn50{60}\t$cl50{60}\n";
	push @out, "N50\t$n50{50}\t$l50{50}\t$cn50{50}\t$cl50{50}\n";
	push @out, "N40\t$n50{40}\t$l50{40}\t$cn50{40}\t$cl50{40}\n";
	push @out, "N30\t$n50{30}\t$l50{30}\t$cn50{30}\t$cl50{30}\n";
	push @out, "N20\t$n50{20}\t$l50{20}\t$cn50{20}\t$cl50{20}\n";
	push @out, "N10\t$n50{10}\t$l50{10}\t$cn50{10}\t$cl50{10}\n";
	push @out, "Total length\t$tl\t\t$ctl\n";
	push @out, "num>=100bp\t\t$nl100\t\t$cnl100\n";
	push @out, "num>=2kb\t\t$nl2000\t\t$cnl2000\n";
	my $non=(1-$ctl/$tl)*100;
	push @out, "Rate if N\t".sprintf "%.2f",$non ,."%\n";
	output("$output",@out);
	}

