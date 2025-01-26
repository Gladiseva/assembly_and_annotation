# Load the necessary library to read FASTA files
library(Biostrings)

# Read the assembly data from the FASTA file
assembly_data <- readDNAStringSet("assembly.fasta")

# Get the number of scaffolds (or blocks)
total_blocks <- length(assembly_data)  # this will give you the number of sequences
print(total_blocks)

# Load the necessary data files
syntenic_block <- read.csv("syntenicBlock_coordinates.csv")
syntenic_region <- read.csv("syntenicRegion_coordinates.csv")

# View the first few rows of each file to understand their structure
head(syntenic_block)
head(syntenic_region)

# Count the number of syntenic blocks
synteny_score <- num_syntenic_blocks / total_blocks
print(synteny_score)
