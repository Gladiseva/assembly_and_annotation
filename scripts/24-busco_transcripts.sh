#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=06:00:00
#SBATCH --job-name=busco_tr
#SBATCH --partition=pibu_el8

WORK_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/final"
OUT_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/evaluation"
mkdir -p $OUT_DIR

PLOT_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/BUSCO"
mkdir -p $PLOT_DIR


module load BUSCO/5.4.2-foss-2021a
module load SeqKit/2.6.1
# Run BUSCO on transcripts
busco -f -i "$WORK_DIR/assembly.all.maker.fasta.all.maker.transcripts.fasta.renamed.filtered.longest.fasta" -l brassicales_odb10 -o "$OUT_DIR/transcripts" -m transcriptome

# Check if the output file exists
if [ ! -f "$OUT_DIR/transcripts/short_summary.specific.brassicales_odb10.transcripts.txt" ]; then
    echo "BUSCO transcripts run failed, check logs."
    exit 1
fi
