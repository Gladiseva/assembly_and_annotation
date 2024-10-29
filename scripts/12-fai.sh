#!/usr/bin/env bash
  
#SBATCH --partition=pibu_el8
#SBATCH --job-name=faidx
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

# load modules
module load SAMtools/1.13-GCC-10.3.0

# set variables
WORK_DIR=/data/users/lgladiseva/annotation_course
ASSEMBLY_HIFIASM=/data/users/lgladiseva/assembly_course/assembly_out/lja/assembly.fasta

cd $WORK_DIR

samtools faidx $ASSEMBLY_HIFIASM                      