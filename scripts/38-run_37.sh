#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --job-name=ortho
#SBATCH --partition=pibu_el8

# load module
module load R/4.1.0-foss-2021a
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

WORKDIR=/data/users/lgladiseva/annotation_course
RSCRIPT=/data/users/lgladiseva/annotation_course/scripts/37-parse_ortho.R
OUTPUT_DIR=$WORKDIR/Plots_orthofinder

mkdir -p $OUTPUT_DIR

Rscript $RSCRIPT

#look for stats Statistics_PerSpecies.tsv
#/data/users/lgladiseva/annotation_course/scripts/genespace/orthofinder/Results_Nov20/Comparative_Genomics_Statistics