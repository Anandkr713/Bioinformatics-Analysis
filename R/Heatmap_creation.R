#Create a Heatmap

# Import the CSV file
csv <- read.csv("/csv location")

# Select the columns of data to include in the heatmap
csv2 <- csv[, c( 3, 4,5,6)]
colnames(csv)
colnames(csv2)
csvdf <- as.data.frame(csv)
# Convert the data to a numeric matrix
csv_mat <- as.matrix(csv2)
rownames(csv_mat) <- csv_df$Name
colnames(csv_mat) <- c('label1', 'label2')

# Create a heatmap
#heatmap(csv_mat, Rowv = NA, Colv = NA, margins = c(10, 10), main = "Heatmap title")
csv_melt <- melt(csv_df[,-1])
X2 <- c('label1','label2')
ggp1 <- ggplot(csv_melt, aes(Name , variable)) +
  geom_tile(aes(fill = value))+
  scale_fill_gradient(low = "white", high = "red")+
  coord_flip()+
  labs(y = "pltlabels_y_axis", x = "pltlabel_x_axis")+
  ggtitle("output_file_name")

ggp1
#ggsave("csv.png", width = 6, height = 3)
