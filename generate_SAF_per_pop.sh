module load angsd

GENOME="/[path]/[to]/[reference]/[genome].fa"
FILTERS=" -uniqueOnly 1 -remove_bads 1 -minMapQ 30 -minQ 30 -trim 15 -only_proper_pairs 1"

angsd -bam [bamlist_1] -doSaf 1 -anc $GENOME -ref $GENOME -rf [contig_map] $FILTERS -sites [position file].pos -GL 1 -P 5 -doCounts 1 -setMinDepth 2 -out [outputfolder/prefix]
realSFS [outputfolder/prefix].saf.idx -P 15 > [outputfolder/prefix].sfs

angsd -bam [bamlist_2] -doSaf 1 -anc $GENOME -ref $GENOME -rf [contig_map] $FILTERS -sites [position file].pos -GL 1 -P 5 -doCounts 1 -setMinDepth 2 -out [outputfolder/prefix]
realSFS [outputfolder/prefix].saf.idx -P 15 > [outputfolder/prefix].sfs
