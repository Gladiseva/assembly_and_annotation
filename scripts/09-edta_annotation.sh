#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=20
#SBATCH --mem=128G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=EDTA2
#SBATCH --partition=pibu_el8

# Fix for locale issues
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#BEFORE RUNNING do: git clone https://github.com/oushujun/EDTA.git in $WORKDIR

# Load the required module and activate conda environment
module load Anaconda3
eval "$(conda shell.bash hook)"
conda activate EDTA2

# Define working directory and genome file
WORKDIR=/data/users/lgladiseva/annotation_course
GENOME=/data/users/lgladiseva/assembly_course/assembly_out/lja/assembly.fasta
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $WORKDIR/EDTA_annotation
cd $WORKDIR/EDTA_annotation

perl $WORKDIR/EDTA/EDTA.pl \
--genome $GENOME --species others --step all \
--cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \
--anno 1 --threads $THREADS
