#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=flye_asmbly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
OUTDIR=$WORKDIR/assembly_out

module load Flye/2.9-GCC-10.3.0

flye --pacbio-hifi $WORKDIR/PacBioHiFi/PacBioHiFi_trimmed.fastq.gz --out-dir $OUTDIR \
    --threads 16 --genome-size 135m
