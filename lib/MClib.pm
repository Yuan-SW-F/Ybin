package MClib;
use strict qw(subs refs);
use feature qw(say);
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(lib lane com);

sub lib
{
	my %ist;
	my $lib=shift || "lib.lst";
	open IN,$lib ||die "please input the file : lib.lst !!!";
	while (<IN>){
		/(\S+)\s+(\S+)/;
		$ist{$1}=$2;
	}
	close IN;
	return %ist;
}

sub lane
{
	my (@seqs,%check,$seq,%lib,%read,%name,%fix);
	my $lane=shift || "lane.lst";
	open IN,$lane || say "please input the file : lane.lst !!!";
	while (<IN>){
		/^(\S+)/;
		next if exists $check{$1};
		$seq=$1;
		$check{$1}=1;
		if ($seq=~/([^\/]*L\d\_(\w+\-[^\/]+))\_(\d)\.([^\/]+)/ || $seq=~/(([^\/]+))\_(\d)\.([^\/]+)/){
			$lib{$seq}=$2;
			$name{$seq}=$1;
			$fix{$seq}=$4;
			push @seqs,$seq if $3 == 1;
		}
	}
	return (@seqs,%name,%lib,%fix);
}

sub com
{
	my (@seqs,%check,$seq,%lib,%read,%name,%ist,%fix);
	my $line=shift;
	open IN,$line || say "please check input file !!!";
	while (<IN>){
		/^(\S+)\s+(\d+)/;
		next if exists $check{$1};
		$seq=$1;
		$check{$1}=1;
		my $ist=$2;
		if ($seq=~/([^\/]*L\d\_(\w+\-[^\/]+))\_(\d)\.([^\/]+)/ || $seq=~/(([^\/]+))\_(\d)\.([^\/]+)/){
			$lib{$seq}=$2;
			$name{$seq}=$1;
			$fix{$seq}=$4;
			$ist{$2}=$ist;
			push @seqs,$seq if $3 == 1;
		}
	}
	return (%name,%lib,%ist,%fix);
}

__END__
