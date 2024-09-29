#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=hifiasm_asmbly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
HIFI_READS=$WORKDIR/PacBioHiFi/PacBioHiFi_trimmed.fastq.gz
OUTDIR=$WORKDIR/assembly_out/hifiasm

mkdir -p $OUTDIR

module load hifiasm/0.15.2-GCCcore-10.3.0

hifiasm -o $OUTDIR/PacBioHiFi_trimmed.asm -t 32 $HIFI_READS
