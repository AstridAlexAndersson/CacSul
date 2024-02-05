library(ggplot2)
library(readxl)

setwd("~/[path]/[folder]")

YCC.PC <- read_xlsx("[data].xlsx")

ggplot(data = YCC.PC, aes(x = PC1, y = PC2)) +
  geom_point(aes(color = POP), size =3) +
  scale_color_manual(values=c('C s abbotti' = 'red', 'C s parvula'='royalblue','C s occidentalis'='darkturquoise','C s citrinocristata'='orange', 'C s sulphurea'='magenta', 'C s djampeana'='forestgreen', 'C s paulandrewi'='purple')) +
  theme_classic(base_size = 24) +
  xlab("PC1") + 
  ylab("PC2") +
  theme(legend.position="bottom", legend.text = element_text(face = "italic"))
