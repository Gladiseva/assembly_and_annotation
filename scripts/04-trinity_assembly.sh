#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --job-name=trinity_asmbly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
SHADIR=$WORKDIR/IlluminaRNAseq
OUTDIR=$WORKDIR/assembly_out/trinity

mkdir -p $OUTDIR

module load Trinity/2.15.1-foss-2021a

Trinity --seqType fq --left $SHADIR/filtered_trimmed_RNAseq_1.fastq.gz --right $SHADIR/filtered_trimmed_RNAseq_2.fastq.gz \
        --CPU 32 --max_memory 60G --output $OUTDIR
