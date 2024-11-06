# Load necessary libraries
library(circlize)
library(ComplexHeatmap)
library(ape)
library(GenomicRanges)  # Helps with genomic range manipulations if needed

# Load and filter the TE annotation data
anno_data <- read.gff("assembly.fasta.mod.EDTA.TEanno.gff3", na.strings = c(".", "?"), GFF3 = TRUE)
superfamily_counts <- table(anno_data$type)

# Identify the most abundant superfamily
most_abundant_superfamily <- names(superfamily_counts)[which.max(superfamily_counts)]
filtered_te_annotations <- anno_data[anno_data$type != most_abundant_superfamily, ]

# Further filter out unwanted superfamilies
unwanted_superfamilies <- c("target_site_duplication", "repeat_region", "long_terminal_repeat", 'LTR_retrotransposon')
filtered_te_annotations <- filtered_te_annotations[!(filtered_te_annotations$type %in% unwanted_superfamilies), ]

# Prepare the FAI data and sort to find the top 20 longest scaffolds
fai_data <- read.table("assembly.fasta.fai", sep = "\t", header = FALSE)
fai_data$V1 <- gsub("contig_", "", fai_data$V1)
fai_data_sorted <- fai_data[order(-fai_data$V2), ]
top_20_scaffolds <- fai_data_sorted[1:20, ]

# Prepare ideogram data for the circos plot
ideogram_data <- data.frame(
  scaffold = top_20_scaffolds$V1,
  start = 0,
  end = top_20_scaffolds$V2
)

# Initialize circos plot with the ideogram data
circos.clear()
circos.genomicInitialize(ideogram_data)

# Define colors for the superfamilies and plot the density
superfamily_colors <- c( "orange", "magenta")
most_abundant_superfamilies <- c('Gypsy_LTR_retrotransposon',"Copia_LTR_retrotransposon")
  
for (i in 1:length(most_abundant_superfamilies)) {
  # Filter the data for the current superfamily
  superfamily_data <- filtered_te_annotations_2[filtered_te_annotations_2$type == most_abundant_superfamilies[i],]
  
  # Select relevant columns: scaffold (V1), start (V4), and end (V5)
  superfamily_data <- superfamily_data[, c(1, 4, 5)]
  colnames(superfamily_data) <- c("scaffold", "start", "end")
  
  # Plot the density
  circos.genomicDensity(superfamily_data, col = superfamily_colors[i], track.height = 0.1, window.size = 1e6)
}

library(ComplexHeatmap)

# Step 2: Create the legend
legend <- Legend(
  labels = most_abundant_superfamilies,           # Labels of the legend (superfamilies)
  legend_gp = gpar(fill = superfamily_colors),  # Corresponding colors
  title = "Superfamilies",              # Title of the legend
  title_position = "topleft"          # Position of the title
)

# Step 3: Draw the legend on the plot
draw(legend, x = unit(1, "npc") - unit(5, "mm"), y = unit(1, "npc") - unit(5, "mm"), just = c("right", "top"))


# Clear circos plot after usage
circos.clear()
