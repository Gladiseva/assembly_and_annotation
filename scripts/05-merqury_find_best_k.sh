#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury_find_k
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course
READS_DIR=$WORK_DIR/PacBioHiFi/PacBioHiFi_trimmed.fastq.gz
CONTAINER_DIR=/containers/apptainer/merqury_1.3.sif

export MERQURY="/usr/local/share/merqury"

apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
sh $MERQURY/best_k.sh 130000000
#tolerable collision rate: 0.001 => 18.4591