module load angsd

#genotype likelihood estimation
angsd -P 8 -bam [bamlist_1_ind_per_subspecies] -ref [reference_genome].fa -doMaf 1 -Gl 1 -doGlf 2 -doMajorMinor 1 -out [prefix] -uniqueOnly 1 -remove_bads 1 -trim 15 -only_proper_pairs 1 -setMaxDepth 40 -setMinDepth 0.05 -minMapQ 30 -minQ 20 -minInd 5 -skipTriallelic 1 -doGeno 2 -doPost 1 -doCounts 1 -doplink 2 -doQsDist 1 -doDepth 1

#makepositionfile
zcat [prefix].beagle.gz | cut -f 1-3 | tr "_" "\t" | tail -n +2 > [prefix].pos
