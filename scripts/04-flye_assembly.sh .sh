#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye_asmbly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
CONTAINER_DIR=/containers/apptainer/flye_2.9.5.sif
READS_DIR=$WORKDIR/PacBioHiFi/PacBioHiFi_trimmed.fastq.gz
OUTDIR=$WORKDIR/assembly_out/flye

mkdir -p $OUTDIR

apptainer exec --bind $WORKDIR $CONTAINER_DIR flye --pacbio-hifi $READS_DIR --out-dir $OUTDIR --threads 16 --genome-size 135m