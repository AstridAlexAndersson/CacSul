#set the input file to process
name=$(sed -n ${SLURM_ARRAY_TASK_ID}p namelist)

#get the data
mapDamage -i ${name}.bam -r [REFERENCE GENOME] -d ${name} --rescale
