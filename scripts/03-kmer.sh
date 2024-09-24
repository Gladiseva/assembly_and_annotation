#!/bin/bash
  
#SBATCH --time=4:00:00
#SBATCH --mem=40G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=kmer_counting_pacbio
#SBATCH --partition=pibu_el8

# Define directories
WORK_DIR="/data/users/lgladiseva/assembly_course/"
PACBIO_DIR=${1:-"/data/users/lgladiseva/assembly_course/PacBioHiFi/"}  # Default PacBio HiFi reads directory
OUTPUT_DIR="/data/users/lgladiseva/assembly_course/kmer_counts"
PACBIO_TEMP_DIR="${OUTPUT_DIR}/decompressed_pacbio"

# Create output and temp directories if they don't exist
mkdir -p ${OUTPUT_DIR}
mkdir -p ${PACBIO_TEMP_DIR}

# Decompress PacBio HiFi files
echo "Decompressing PacBio HiFi files..."
for file in ${PACBIO_DIR}/*.fastq.gz; do
    zcat "$file" > "${PACBIO_TEMP_DIR}/$(basename ${file%.gz})"
done

# Load necessary modules
module load Jellyfish/2.3.0-GCC-10.3.0

# Run Jellyfish count on PacBio HiFi reads
echo "Running Jellyfish k-mer count on PacBio HiFi reads..."
jellyfish count -C -m 21 -s 5G -t 4 ${PACBIO_TEMP_DIR}/*.fastq -o ${OUTPUT_DIR}/pacbio_reads.jf

# Generate k-mer histogram from the counts
echo "Generating k-mer histogram for PacBio HiFi reads..."
jellyfish histo -t 4 ${OUTPUT_DIR}/pacbio_reads.jf > ${OUTPUT_DIR}/pacbio_reads.histo

echo "K-mer counting and histogram creation for PacBio HiFi reads completed."
