#set the input file to process
name=$(sed -n ${SLURM_ARRAY_TASK_ID}p namelist_gal)

module load bwa
module load biokit

#filter out and only retain reads that map uniquely to cockatoo 
/fastq_screen/bin/fastq_screen --tag --filter 100000 /RawFASTQ/${name}/${name}_1.fastq.gz /RawFASTQ/${name}/${name}_2.fastq.gz -outdir /FastQScreen

#fix the mate pair issue with bbtools repair.sh
module load bbtools/38.96
repair.sh in1=/FastQScreen/${name}_1.tagged_filter.fastq.gz in2=/FastQScreen/${name}_2.tagged_filter.fastq.gz out1=/FastQScreen/fixed/${name}_1.tagged_filter_fixed1.fastq out2=/FastQScreen/fixed/${name}_2.tagged_filter_fixed2.fastq
