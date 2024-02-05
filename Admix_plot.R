library(RColorBrewer)
library(ggplot2)

setwd("~/[path]/[folder]")

# read population labels and estimated admixture proportions
pop<-read.table("[FILENAME].info",as.is=T)
q<-read.table("[FILENAME]_K6.qopt")

# order according to population
ord<-order(pop[,1])
coul <- brewer.pal(8, "Set2")
barplot(t(q)[,ord],col=coul,space=0,border=NA,ylab="Admixture proportions for K=6)")
text(tapply(1:nrow(pop),pop[ord,1],mean),-0.1,unique(pop[ord,1]),xpd=T,srt=+80)
abline(v=cumsum(sapply(unique(pop[ord,1]),function(x){sum(pop[ord,1]==x)})),col=1,lwd=1.2)
