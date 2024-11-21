#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=context
#SBATCH --partition=pibu_el8

module load Anaconda3
eval "$(conda shell.bash hook)"
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/OMArk_conda/

# fragment
python /data/users/lgladiseva/annotation_course/scripts/omark_contextualize.py fragment -m /data/users/lgladiseva/annotation_course/gene_annotation/final/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta.omamer -o omark_output/
# missing
python /data/users/lgladiseva/annotation_course/scripts/omark_contextualize.py missing -m /data/users/lgladiseva/annotation_course/gene_annotation/final/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta.omamer -o omark_output/