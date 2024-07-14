#set the input file to process
name=$(sed -n ${SLURM_ARRAY_TASK_ID}p namelist)

samtools merge ${name}_PE_ME_merged.bam ${name}_PE.bam ${name}_ME.bam

samtools sort -m 24G -o ${name}_PE_ME_merged_sort.bam ${name}_PE_ME_merged.bam

samtools index ${name}_PE_ME_merged_sort.bam

picard64 AddOrReplaceReadGroups I=${name}_PE_ME_merged_sort.bam O=${name}_PE_ME_merged_sort_RG.bam ID=${name}_PE_ME SM=${name} LB=${name} PL=illumina PU=illumina CN=Macrogen VALIDATION_STRINGENCY=SILENT

samtools sort -m 24G -o ${name}_PE_ME_merged_sort_RG_resort.bam ${name}_PE_ME_merged_sort_RG.bam

samtools index ${name}_PE_ME_merged_sort_RG_resort.bam

picard64 MarkDuplicates I=${name}_PE_ME_merged_sort_RG_resort.bam O=${name}_PE_ME_merged_sort_RG_resort_Mkdup.bam AS=TRUE M=${name}_PE_ME_merged_sort_RG_resort.metrics REMOVE_DUPLICATES=FALSE VALIDATION_STRINGENCY=LENIENT

samtools sort -m 24G -o ${name}_PE_ME_merged_sort_RG_resort_Mkdup_finalsort.bam ${name}_PE_ME_merged_sort_RG_resort_Mkdup.bam

samtools index ${name}_PE_ME_merged_sort_RG_resort_Mkdup_finalsort.bam

samtools flagstat ${name}_PE_ME_merged_sort_RG_resort_Mkdup_finalsort.bam > ${name}_PE_ME_merged_sort_RG_resort_Mkdup_finalsort.flagstat

samtools depth -a ${name}_PE_ME_merged_sort_RG_resort_Mkdup_finalsort.bam | awk '{sum+=$3; sumsq+=$3*$3} END { print "Average = ",sum/NR; print "Stdev = ",sqrt(sumsq/NR - (sum/NR)**2)}' > coverage_${name}.txt
