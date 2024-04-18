#Volcano plot creation 

```{r}
data_source <- read.csv("data_source")
colnames(data_source)[1] <- "col_name"
# Add a column to the data frame to specify if they are UP- or DOWN- regulated (log2fc respectively positive or negative)<br /><br /><br />
data_source$diffexpressed <- "NO"
# if log2Foldchange > 0.6 and pvalue < 0.05, set as "UP"<br /><br /><br />
data_source$diffexpressed[n21v6vol$log2fc > 0.6 & data_source$pvalue < 0.05] <- "UP"
# if log2Foldchange < -0.6 and pvalue < 0.05, set as "DOWN"<br /><br /><br />
data_source$diffexpressed[data_source$log2fc < -0.6 & data_source$pvalue < 0.05] <- "DOWN"
# Explore a bit<br /><br /><br />
head(data_source[order(data_source$pvalue) & data_source$diffexpressed == 'DOWN', ])

# Create a new column "delabel" to de, that will contain the name of the top 30 differentially expressed genes (NA in case they are not)
#data_source$delabel <- ifelse(data_source$gene_name %in% head(data_source[order(data_source$pvalue), "gene_name"], 30), data_source$gene_name, NA)

# Biostatsquid theme
theme_set(theme_classic(base_size = 20) +
            theme(
              axis.title.y = element_text(face = "bold", margin = margin(0,20,0,0), size = rel(1.1), color = 'black'),
              axis.title.x = element_text(hjust = 0.5, face = "bold", margin = margin(20,0,0,0), size = rel(1.1), color = 'black'),
              plot.title = element_text(hjust = 0.5)
            ))

# Plot the volcano plot


ggplot(data_source, aes(x = log2fc, y = -log10(pvalue), col = diffexpressed , label = delabel)) +
  geom_vline(xintercept = c(-0.6, 0.6), col = "gray", linetype = 'dashed') +
  geom_hline(yintercept = -log10(0.05), col = "gray", linetype = 'dashed') +
  geom_point(size = 0.5) +
  scale_color_manual(values = c("blue", "grey", "red"), # to set the colours of our variable  
                     labels = c("Downregulated", "Not significant", "Upregulated")) + # to set the labels in case we want to overwrite the categories from the dataframe (UP, DOWN, NO)
  coord_cartesian(ylim = c(0, 7.5), xlim = c(-6, 6)) + # since some genes can have minuslog10padj of inf, we set these limits
  labs(color = 'Severely', #legend_title, 
       x = expression("log"[2]*"fold change"), y = expression("-log"[10]*"p-value")) + 
  scale_x_continuous(breaks = seq(-6, 6,1)) + # to customise the breaks in the x axis
  ggtitle("Gene expression of mice Day 21 vs day 6 non-irradiated") +
  theme(plot.title = element_text(size = 16, face = "bold", hjust = 0) ,axis.title.x = element_text(size = 12), axis.title.y = element_text(size = 12),axis.text = element_text(size = 10), legend.title = element_text(size = 14), legend.text = element_text(size = 12)) +
  geom_text_repel(max.overlaps = Inf , size = 1.75)

ggsave("data_source.png")
```