#!/usr/bin/env bash
  
#SBATCH --time=1-0
#SBATCH --mem=12G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=fai
#SBATCH --partition=pibu_el8

protein_input=/data/users/lgladiseva/annotation_course/gene_annotation/final/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta
WORK_DIR=/data/users/lgladiseva/annotation_course/gene_annotation/final

module load SAMtools/1.13-GCC-10.3.0

cd $WORK_DIR
samtools faidx $protein_input