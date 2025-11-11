library(vcfR)
library(RColorBrewer)
library(dartR)

#if (!require("BiocManager", quietly = TRUE))
 # install.packages("BiocManager")
#BiocManager::install("SNPRelate")

pkg <- "pinfsc50"
vcf_file <- system.file("extdata", "pinf_sc50.vcf.gz", package = pkg)
dna_file <- system.file("extdata", "pinf_sc50.fasta", package = pkg)
gff_file <- system.file("extdata", "pinf_sc50.gff", package = pkg)

setwd("[Insert/working/directory/here]")

HKYCCgen <- gl.read.vcf("[insert_VCF_file_name_here].vcf", verbose = NULL)

dev.off()

gl.grm(
  HKYCCgen, 
  plotheatmap = TRUE,
  legendx = 0,
  legendy = 1,
  verbose = NULL,
)

gl.grm.network(G, HKYCCgen, method = "fr", node.size = 6,
               node.label = TRUE, node.label.size = 2,
               node.label.color = "black",
               title = "Network based on a genomic relationship matrix",
               palette_discrete = discrete_palette,
               save2tmp = FALSE,
               verbose = NULL
)

gl_test <- HKYCCgen
nPop(gl_test)
G_out <- gl.grm(gl_test,plotheatmap=FALSE)

gl.grm.network(G_out, gl_test, method = "fr", node.size = 8, node.label.size = 3)

gl.grm.network(
  G,
  HKYCCgen,
  method = "fr",
  node.size = 6,
  node.label = TRUE,
  node.label.size = 2,
  node.label.color = "black",
  relatedness_factor = 0.25,
  title = "Network based on a genomic relationship matrix",
  palette_discrete = discrete_palette,
  save2tmp = FALSE,
  verbose = NULL
)
