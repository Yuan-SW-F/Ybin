package MClibr;
use strict qw(subs refs);
use feature qw(say);
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(ilib);

sub ilib
{
	my %libinf;
	for (@_){
	my $seq=$1 if /([^\/\s]+)$/;	#151023_I132_FCH3LLMBBXX_L6_RFINunlTAAAARAAPEI-8_1.fq.gz.clean.dup.clean
		if ($seq=~/((L(\d)\_(\w+\-\S+))\_(\d)(\.?\S+))/){
		$libinf{body}=$1;	#L6_RFINunlTAAAARAAPEI-8_1.fq.gz.clean.dup.clean
		$libinf{head}=$2;	#L6_RFINunlTAAAARAAPEI-8_1
		$libinf{lane}=$3;	#6
		$libinf{lib}=$4;	#RFINunlTAAAARAAPEI-8
		$libinf{reads}=$5;	#1
		$libinf{end}=$6;	#.fq.gz.clean.dup.clean
		}else{
			if ($seq=~/((\S+)\_(\d)(\.\S+))/){
				$libinf{body}=$1;
				$libinf{head}=$2;
				$libinf{lane}=$2;
				$libinf{lib}="";
				$libinf{reads}=$3;
				$libinf{end}=$4;
			}
		}
	}
	%libinf;
}

__END__
