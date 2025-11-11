library(readxl)
library(plotly)
library(dplyr)
library(ggplot2)

setwd("[insert/path/to/working/directory]")

data <- read_excel("[insert_excel_filename_with_eigenvectors].xlsx") #6,024

# Assign identities and groups to your samples, based on names in excel files
data <- data %>%
  mutate(Group = case_when(
    grepl("^HK", ID) ~ "Hong Kong cockatoos",
    grepl("^CSSUL", ID) ~ "C sulphurea sulphurea",
    grepl("^CSDJA", ID) ~ "C sulphurea sulphurea",
    grepl("^CSPAR", ID) ~ "C sulphurea parvula",
    grepl("^CSCIT", ID) ~ "C sulphurea citrinocristata",
    grepl("^CSPAUL", ID) ~ "C sulphurea sulphurea",
    grepl("^CSABB", ID) ~ "Masalembu cockatoos",
    grepl("^CSOCC", ID) ~ "C sulphurea occidentalis",
  ))

color_map <- c('Masalembu cockatoos' = 'black', 'C sulphurea sulphurea'='blueviolet','C sulphurea occidentalis'='darkturquoise','C sulphurea citrinocristata'='darkorange2', 'C sulphurea parvula'='yellow', 'Hong Kong cockatoos' ='yellowgreen')
#symbol_list <- c("circle", "square", "diamond", "cross") 

data <- data %>%
  group_by(Group) %>%
  #mutate(Symbol = rep(symbol_list, length.out = n())) %>%
  ungroup()

#2D
fig <- plot_ly(
  data,
  x = ~PC1, y = ~PC2,
  type = "scatter",
  mode = "markers",
  text = ~ID,
  hoverinfo = "text",
  color = ~Group,
  colors = color_map,
  #symbol = ~Symbol,
  #symbols = symbol_list,
  name = ~ID,
  marker = list(
    size = 7,
    opacity = 0.75, 
    line = list(color = "black", width = 1))
)
# manually enter percentages, calculated from eigenvalues 
fig <- fig %>%
  layout(
    title = "PC1 vs PC2",
    scene = list(
      xaxis = list(title = "PC1 (XX.X%)"),
      yaxis = list(title = "PC2 (XX.X%)"),
    )
  )
fig

# 3D
fig <- plot_ly(
  data,
  x = ~PC1, y = ~PC2, z = ~PC3,
  type = "scatter3d",
  mode = "markers",
  text = ~ID,
  hoverinfo = "text",
  color = ~Group,
  colors = color_map,
  #symbol = ~Symbol,
  #symbols = symbol_list,
  name = ~ID,
  marker = list(
    size = 6,
    opacity = 0.90, 
    line = list(color = "black", width = 5))
)
# manually enter percentages, calculated from eigenvalues 
fig <- fig %>%
  layout(
    title = "PC1 vs PC2 vs PC3",
    scene = list(
      xaxis = list(title = "PC1 (XX.X%)"),
      yaxis = list(title = "PC2 (XX.X%)"),
      zaxis = list(title = "PC3 (XX.X%)")
    )
  )
fig
