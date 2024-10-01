#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=lja_asmbly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
READS=$WORKDIR/PacBioHiFi/PacBioHiFi_trimmed.fastq.gz
OUTDIR=$WORKDIR/assembly_out/lja

mkdir -p $OUTDIR

apptainer exec \
  --bind $WORKDIR \
  /containers/apptainer/lja-0.2.sif \
  lja -o $OUTDIR --reads $READS --threads 32
