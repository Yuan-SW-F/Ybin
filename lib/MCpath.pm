package MCpath;
use FindBin;
require Exporter;
@EXPORT_OK = qw($FILTER_PATH $KMER_ANALYSIS_PATH $KMER_GENIE_PATH $MCPIPE $TRIM_PATH $QSUB_PATH $FILTER_PATH $KMER_ANALYSIS_PATH $KMER_GENIE_PATH $TRNT_DIR $STAT_TE2_PATH $FQ_SELECT_PATH $GC_COV_PATH $BLOBPLOT_R $BLASTDB_DIR $TAXDUMP_DIR $LP_DIR);

%EXPORT_TAGS = (all => [ @EXPORT_OK ]);
@ISA		 = qw(Exporter);

BEGIN
{
	$MCPIPE="/ifs1/ST_PLANT/USER/fuyuan/Program/Bin/MCpipe";
	$MC_KMER="$MCPIPE/kmer.pl";
	$MC_FILTER="$MCPIPE/filter.pl";
	$MC_BUSCO="$MCPIPE/busco.pl";
	$MC_BIN="/ifs1/ST_PLANT/USER/fuyuan/Program/Bin/bin";
	
	$TRIM_PATH="/ifs1/ST_PLANT/USER/xushanyun/softwares/NGSQCToolkit_v2.3.3/Trimming/TrimmingReads.pl";
	$QSUB_PATH="/ifs1/ST_PLANT/USER/fuyuan/Program/com_program/qsub-sge.pl";
	$FILTER_PATH="/ifs4/BC_PUB/biosoft/pipe/bc_ba/Assembly_v2/Filter_data/SOAPfilter_v2.2/SOAPfilter_v2.2";
	
	$KMER_ANALYSIS_PATH="/ifs4/BC_PUB/biosoft/pipe/bc_ba/Assembly_v2/kmerfreq_v5.0/kmerfreq";
	$KMER_GENIE_PATH="/ifs1/ST_PLANT/USER/xushanyun/Assemblers/kmergenie-1.6982/kmergenie";
	$TRNT_DIR="/ifs1/ST_PLANT/USER/liyuxiang/common_bin/software/trinityrnaseq_r2012-10-05";
	
	
	
	$STAT_TE2_PATH="/ifs1/ST_PLANT/USER/fuyuan/Program/Bin/Annotation_2016a/bin/01.repeat_finding/repeat_statistics/stat_TE2.pl";
	$FQ_SELECT_PATH="/ifs1/ST_PLANT/USER/fuyuan/Program/new_program/blobology-master/bin/fastaqual_select.pl";
	$GC_COV_PATH="/ifs1/ST_PLANT/USER/fuyuan/Program/new_program/blobology-master/bin/gc_cov_annotate.pl";

	$my_MDIR=0;
	$TEST="my name is test!!!";
	$DEBUGALL = 0;
### Rscript
	$BLOBPLOT_R="/ifs1/ST_PLANT/USER/fuyuan/Program/new_program/blobology-master/bin/makeblobplot.R";

### DATABASE
	$BLASTDB_DIR="/ifs1/pub/database/ftp.ncbi.nih.gov/blast/db/20160509";
	$TAXDUMP_DIR="/ifs1/ST_PLANT/USER/fuyuan/Program/00.preparation/00.database/taxdb/2016620";

### MY_PATH
	$LP_DIR="/ifs1/ST_PLANT/USER/fuyuan/Program/lit_program";
  ##                 END CONFIGURATION AREA                        ##
}
1;
