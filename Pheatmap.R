#setwd("C:/Users/")
setwd("~/R")
library(pheatmap)
library(RColorBrewer)
library(viridis)

Heat_map_data <- read.delim(".txt", row.names=1, header = TRUE)
#Labels your data
Heat_map_data$Label <- paste(Heat_map_data$Feature_ID, row.names(Heat_map_data), sep = " - ")

#Annotations for the heatmap
#Change these to match your column titles of your data
my_samples <- data.frame(sample = c("Embryo_0h","Embryo_6h","Female","Larvae","Male","Pupae"))

#double check that that all of the data is in the correct format (numeric)
str(Heat_map_data)
#Some columns imported as a factor; these lines makes them numeric if needed.
Heat_map_data$Embryo_0h=as.numeric(Heat_map_data$Embryo_0h)
Heat_map_data$Embryo_6h=as.numeric(Heat_map_data$Embryo_6h)
Heat_map_data$Female=as.numeric(Heat_map_data$Female)
Heat_map_data$Larvae=as.numeric(Heat_map_data$Larvae)
Heat_map_data$Male=as.numeric(Heat_map_data$Male)
Heat_map_data$Pupae=as.numeric(Heat_map_data$Pupae)

#change the second number to match the amount of columns in your data
row.names(my_samples) <- colnames(Heat_map_data[,1:16])

all_genes_map <- pheatmap(
  mat = Heat_map_data[,1:16], #change this to match what you input above
  border_color = TRUE,
  color = viridis(10), #number changes the amount of colors available for gradient
  scale = "row",
  show_colnames = TRUE,
  show_rownames = TRUE,
  drop_levels = FALSE,
  fontsize = 5,
  #main = "Heat Shock Proteins",
  cluster_cols = FALSE,
  clustering_distance_rows ="maximum",
  cluster_rows = TRUE,
  clustering_distance_cols = "maximum",
  treeheight_row = 0,
  cellwidth = 6,
  cellheight = 6,
  labels_row = Heat_map_data$Label,
  #cutree_rows = 1, #this is used to separate the heatmap into chunks based on clustering
  legend = TRUE,
  #annotation_col = my_samples
  #annotation_row = my_genes
)
