module load angsd

#genotype likelihood estimation
angsd -P 8 -bam [BAMLIST] -ref [REFERENCE].fa -doMaf 2 -Gl 1 -doGlf 2 -doMajorMinor 1 -out [OUTPUT_PREFIX] -uniqueOnly 1 -remove_bads 1 -trim 15 -only_proper_pairs 1 -SNP_pval 1e-6 -minMapQ 30 -minQ 30 -minInd 13 -setMinDepthInd 4 -geno_minDepth 4 -minMaf 0.01 -doGeno 2 -doPost 1 -doCounts 1 -doplink 2 -doQsDist 1 -doDepth 1
