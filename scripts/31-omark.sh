#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=omark
#SBATCH --partition=pibu_el8

module load Anaconda3
eval "$(conda shell.bash hook)"
conda activate /data/courses/assembly-annotation-course/CDS_annotation/containers/OMArk_conda/

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/lgladiseva/annotation_course"

protein="$WORKDIR/gene_annotation/final/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta"
splice="$WORKDIR/gene_annotation/evaluation/omark/all_isoforms_splice.txt"

OMArk="/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/"

wget https://omabrowser.org/All/LUCA.h5
omamer search --db  LUCA.h5 --query ${protein} --out ${protein}.omamer

omark -f ${protein}.omamer -of ${protein} -i $splice -d LUCA.h5 -o omark_output