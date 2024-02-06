#Modified from Eliason, C. M., Hains, T., McCullough, J., Andersen, M. J., & Hackett, S. J. (2022). 
#Genomic novelty within a “great speciator” revealed by a high-quality reference genome of the collared kingfisher 
#(Todiramphus chloris collaris). G3, 12(11), jkac260.

setwd("~/[path]/[folder]")

library(ggplot2)
library(dplyr)

source("plotPsmc_lcWGS.r")
#x1 <- psmc.result(file="filename.psmc", mu=[mutation_rate], g=[generation_time], i.iteration=[number of iterations], FNR=False_neg_rate])
x2 <- psmc.result(file="AMNH345474.autosome.bird.psmc", mu=1.05e-8, g=14.3, i.iteration=25, FNR=0.277996)
x3 <- psmc.result(file="AMNH619666.spec_depth.autosome.bird.psmc", mu=1.05e-8, g=14.3, i.iteration=25, FNR=0.277996)
x4 <- psmc.result(file="AMNH619675.spec_depth.autosome.bird.psmc", mu=1.05e-8, g=14.3, i.iteration=25, FNR=0.207521)

# Combine into single data frame
#names(x1) <- seq_along(x1)
names(x2) <- seq_along(x2)
names(x3) <- seq_along(x3)
names(x4) <- seq_along(x4)

#df1 <- plyr::ldply(x1, .id="iter")
df2 <- plyr::ldply(x2, .id="iter")
df3 <- plyr::ldply(x3, .id="iter")
df4 <- plyr::ldply(x4, .id="iter")

#df1$Species <- "[inset name]"
df2$Species <- "C s parvula"
df3$Species <- "C s occidentalis"
df4$Species <- "C s citrinocristata"

df <- rbind(df2,df3,df4)
df$alpha <- ifelse(df$iter==1, 1, 0.05)

df <- df %>% group_by(Species,iter) %>% slice(9:n())
head(df)

#set glaciation period
igp <- data.frame(start=c(17000), end=c(120000))

ggplot(df, aes(x=YearsAgo, y=Ne, alpha=alpha, group=paste0(iter,Species), color=Species)) +
  geom_step() +
  scale_color_manual(values=c('C s parvula'='royalblue','C s occidentalis'='darkturquoise','C s citrinocristata'='orange') +
  #geom_rect(data = igp, aes(colour="grey", xmin=igp$start, xmax=igp$end, ymin=-1e6, ymax= 1e9,  alpha=0.5)) +
  annotate("rect",xmin=igp$start, xmax=igp$end, ymin=0, ymax=Inf,colour='lightgrey',alpha=0.1) +
  scale_alpha_identity() +
  scale_x_log10(limits=c(10^3.6, 10^6.1), breaks=c(1e4, 1e5, 5e5, 1e6), labels=c('10 Kya', '100 Kya', '500 Kya', '1 Mya')) +
  scale_y_log10(limits=c(2.5e3, 3e4), breaks=c(5e3, 1e4, 3e4), labels=c('5k', '10k', '30k')) +
  annotation_logticks(side="bl") +
  theme_classic(base_size = 18) +
  theme(legend.position="top", legend.text = element_text(face = "italic")) +
  labs(x = "Years ago", y = "Effective population size") 

ggsave("[name].pdf", width=11, height=7)

