library(ggplot2)
library(readxl)

setwd("~/Desktop/YCC data postdoc")

data <- read_excel("da_figure.xlsx")
data <- read_excel("da_figure_simpler.xlsx")
data <- read_excel("Da_nomarine.xlsx")

greyzone <- data.frame(start=c(0.005), end=c(0.02))

ggplot(data = data, aes(x = Da, y = Pairwise_comparison, color = Category, shape = Classification)) +
  geom_point(size = 3) +
  #geom_errorbar(aes(x = Da, ymin = 0.5, ymax = 2),color="#999999",width=0.1,size=0.3) +
  #geom_text(aes(label=Pairwise_comparison),hjust=-0.7, vjust=-0.6,size=2,angle=90)+
  scale_x_log10(limits=c(5e-5, 1.3e-1), breaks=c(5e-5, 5e-4, 5e-3, 5e-2, 1.5e-1), labels=c('0.00005', '0.0005', '0.005', '0.05', '0.15')) +
  annotate("rect",xmin=0.005, xmax=greyzone$end, ymin=0, ymax=Inf,colour='lightgrey',alpha=0.1) +
  xlab("Genetic distance (da)") +
  theme_classic(base_size = 16) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_shape_manual(values=c("cross", "triangle", "circle", "square")) +
  scale_color_manual(values=c("#ff7f00", "#984ea3","#377eb8","#4daf4a","#e41a1c","#a65628"),name=NULL) +
  theme(legend.position="bottom")

ggsave("Da_sul.pdf", width=12, height=10)

?  scale_shape_manual
