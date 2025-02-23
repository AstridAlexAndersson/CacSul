library(ggplot2)
library(gridExtra)
library("ape")
library("pegas")
library("seqinr")
library(viridis)
library(viridisLite)

setwd("~/Desktop/[FOLDER]")

###READ DNA data into R
#I use "YCC" as the data name i.e. Yellow-Crested Cockatoos, but you can change this
YCC<-read.dna("[INDIVIDUAL_GENE_FASTAFILE].fas", format="fasta")
YCC

#this info file contains 2 columns of data "ID" with sample names, and "Species_16S" with population/species info
YCC.info<-read.csv("[INFO_FILE}.info.csv",header=T)
YCC.info
YCC.info$ID
labels(YCC)

###CHECKING FOR LABELS (SAME AS labels(data))...LABEL ORDER IMPORTANT IN BOTH .CSV AND FASTA FILES
L<-sapply(strsplit(labels(YCC)," "),"[",1)
L

L<-labels(YCC)
L

###need to match up the names from the fasta file with names in the meta file
YCC.info1<-YCC.info[which(YCC.info$ID%in%L),]
YCC.info1

unique(YCC.info1$Species_16S)

L[L%in%YCC.info1$ID]
L

#check that label order matches
duplicated(L) #had to remove double occurances from the fasta file (duplicate sequence lables and duplicate sequences with different labels!!)
L[which(duplicated(L))]

YCC.info2<-YCC.info1[order(match(YCC.info1$ID,L)),]
YCC.info2

all(YCC.info2$ID==L)

######################### HAPLOTYPE NETWORK #################################################################
#extract the haplotypes which are used to reconstruct the RMST after computing the pairwise Hamming distances

hac <- haplotype(YCC,strict = F,decreasing=F,what="frequencies")
hac

dac <- dist.dna(hac, "N")
dac

ntac <- rmst(dac, quiet = TRUE)
ntac

hap.div(YCC) ##computes haplotype diversity from DNA sequences

nuc.div(YCC)

plot(ntac)

plot(ntac, fast = TRUE)

#change threshold
plot(ntac, fast = TRUE, threshold = c(1, 40))
plot(ntac, threshold = c(1, 40))

args(pegas::: plot.haploNet)

###Size of haplofreq used to display frequency
(sz <- summary(hac))

###Frequency order
(nt.labs <- attr(ntac, "labels"))

###reorder frequencies
sz <- sz[nt.labs]
sz

############################################PLOT by species###########################################
#using reordered frequencies sz <- sz[nt.labs]
plot(ntac, size = sz)


s2<-haploFreq(YCC,fac=paste(YCC.info2$Species,sep="_"),haplo=hac)
s2

s2 <- s2[nt.labs, ]
s2

#legend 
plot(ntac, size = sz, pie = s2, show.mutation=F, legend = c(-150,-10), scale.ratio = 1)

#introduce colour, put number of colours in "20" placeholder e.g. number of countries
#add link length value from ntac step in the threshold
v<-viridis(8, alpha = 1, begin = 0, end = 1, direction = 1, option = "D")
v

#show.mutation=T for true and 3 for number, F for false, CHANGE THRESHOLD according to your step number
plot(ntac, size = sz, pie = s2, show.mutation=3, bg=v,threshold = c(1,40))

plot(ntac, size = sz, pie = s2, legend = c(10,-10),show.mutation=3, labels = TRUE, bg=v,threshold = c(1,40))
