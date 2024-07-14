name=$(sed -n ${SLURM_ARRAY_TASK_ID}p namelist)

#make input file
bcftools mpileup -C 50 -q 30 -Q 20 -Ou -f [REFERENCE].fa ${name}.bam | bcftools call -c - | vcfutils.pl vcf2fq -d 3 -D 18 | gzip > ${name}.fq.gz

#make psmcfa
PSMC_FQ/psmc-master/utils/fq2psmcfa -q20 ${name}.fq.gz > ${name}.psmcfa

#run psmc
PSMC_FQ/psmc-master/psmc -N30 -t5 -r5 -p "4+30*2+4+6+10" -o ${name}.psmc ${name}.psmcfa
