#!/usr/bin/env bash
  
#SBATCH --time=1-00:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=fastqc
#SBATCH --partition=pibu_el8

# run with sbatch ./scripts/01-run_fastqc.sh /data/users/lgladiseva/assembly_course/IlluminaRNAseq/filtered_trimmed_RNAseq_1.fastq.gz

# Set default WORKDIR and output directory
WORKDIR=/data/users/lgladiseva/assembly_course
OUTPUT_DIR=$WORKDIR/fastqc_output

# Check if FASTQ_FILE is provided as an argument, otherwise exit with usage message
if [ -z "$1" ]; then
  echo "Usage: $0 <path_to_fastq_file>"
  exit 1
fi

# Assign the first argument as FASTQ_FILE
FASTQ_FILE=$1

# Create output directory if it does not exist
mkdir -p $OUTPUT_DIR

# Run FastQC using apptainer
apptainer exec \
    --bind $WORKDIR \
    /containers/apptainer/fastqc-0.12.1.sif \
    fastqc \
    --outdir $OUTPUT_DIR \
    $FASTQ_FILE