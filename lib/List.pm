################## this package is used 
#
#Created on 2013-09-14

package List;
use strict qw(subs refs);
require Exporter;
@ISA= qw(Exporter);
@EXPORT = qw(read_cds read_protein check_cds prepare_module);

sub prepare_module{
    my($file,$dir)=@_;
    open PM,$file || die $!;
    open OU,">$dir/orthomcl_module.pm" || die $!;
    while(<PM>){
        if(/^our \$PATH_TO_ORTHOMCL/){
	   print OU "our \$PATH_TO_ORTHOMCL	= \"$dir\/\";\n";
	}else{
	   print OU $_;
	}
    }
    close PM;
    close OU;
}

sub read_cds{
    my($file,$dir)=@_;
    open IN,$file || die "cds list not exist,please check";
    open OUT,"> $dir/all.cds" || die $!;
    open GG,"> $dir/all.gg" || die $!;
    while(<IN>){
        chomp;
        my @line=split;
        $/=">";
        print GG "$line[1]:";
	die "$line[0] is not exists!\n" unless(-e "$line[0]");
        open FASTA,$line[0] || die $!;
        while(<FASTA>){
            chomp;
            my($title,$seq)=split(/\n/,$_,2);
            next unless($title && $seq);
            my($id)=$title=~/^(\S+)/;
            my $new_id="$id\_$line[1]";
               $seq=~s/\s+//g;
	       $seq=uc($seq);
	       $seq=~s/TAA$|TAG$|TGA$//;
	       my($termination,$triple)=check_cds($seq);
	    if(!$termination || !$triple){
	      print "$title have pre-stop codon or not triple!\n";
	      next;
            }	      
            print OUT ">$new_id\n$seq\n";
            print GG " $new_id";
        }
	print GG "\n";
	$/="\n";
	close FASTA;
    }
    close IN;
    close OUT;
    close GG;
}

sub read_protein{
    my($file,$dir)=@_;
    open IN,$file || die "protein list not exist,please check";
    open OUT,"> $dir/all.pep" || die $!;
    open GG,"> $dir/all.gg " || die $!;
    while(<IN>){
        chomp;
        my @line=split;
        $/=">";
        print GG "$line[1]:";
	open FASTA,$line[0] || die $!;
	while(<FASTA>){
	    chomp;
	    my($title,$seq)=split(/\n/,$_,2);
	    next unless($title && $seq);
	    my($id)=$title=~/^(\S+)/;
	    my $new_id="$id\_$line[1]";
	       $seq=~s/\s+//g;
	       $seq=uc($seq);
	    my $stop=$seq=~ tr/[^A-Za-z]//;
	    my $cut=length($seq)-$stop;
	    print OUT ">$new_id\n$seq\n" if(!$cut);
	    print GG " $new_id" if(!$cut);
	}
	print GG "\n";
	$/="\n";
	close FASTA;
   }
   close IN;
   close OUT;
   close GG;
}

sub check_cds{
    my $file=shift;
    my $len=length($file);
    my($stop,$triple)=(0,0);
       $triple=1 if($len%3==0);
       $stop=1;
    for(my $i=3;$i<$len;$i +=3){
	my $codon =substr($file,$i,3);
           $stop=0 if($codon eq 'TAA' || $codon eq'TAG' ||$codon eq 'TGA');
    }
    return ($stop,$triple);
}
