#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --job-name=folders
#SBATCH --partition=pibu_el8

# load module
module load R/4.1.0-foss-2021a
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

RSCRIPT=/data/users/lgladiseva/annotation_course/scripts/33-prep_folders_genespace.R

Rscript $RSCRIPT