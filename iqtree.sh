module load iqtree/2.2.0.3

iqtree -s [file].min4.fasta -v -m TEST -bb 10000 -bnni -st DNA -nt AUTO

chmod -R 777 *
