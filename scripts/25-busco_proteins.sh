#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=06:00:00
#SBATCH --job-name=busco_proteins
#SBATCH --partition=pibu_el8

# Set directory paths
WORK_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/final"
OUT_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/evaluation"
PLOT_DIR="$OUT_DIR/BUSCO"

# Create output directory
mkdir -p $OUT_DIR
mkdir -p $PLOT_DIR

# Load necessary modules
module load BUSCO/5.4.2-foss-2021a
module load SeqKit/2.6.1

# Run BUSCO on proteins
busco -f -i "$WORK_DIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.longest.fasta" \
      -l brassicales_odb10 -o "$OUT_DIR/proteins" -m proteins

# Check if the BUSCO output for proteins exists
if [ ! -f "$OUT_DIR/proteins/short_summary.specific.brassicales_odb10.proteins.txt" ]; then
    echo "BUSCO proteins run failed, check logs."
    exit 1
fi

echo "BUSCO run for proteins completed successfully."
