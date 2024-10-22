#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=128G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=EDTA
#SBATCH --partition=pibu_el8

module load Anaconda3/2022.05
conda env create -f EDTA_2.2.x.yml
conda activate EDTA2

WORKDIR=/data/users/lgladiseva/annotation_course
GENOME=/data/users/lgladiseva/assembly_course/assembly_out/lja/assembly.fasta
THREADS=$SLURM_CPUS_PER_TASK

mkdir -p $WORKDIR/EDTA_annotation
cd $WORKDIR/EDTA_annotation

apptainer exec  \
--bind /usr/bin/which:/usr/bin/which \
--bind /data \
/data/courses/assembly-annotation-course/containers2/EDTA_v1.9.6.sif \
EDTA.pl --genome $GENOME --species others --step all --cds /data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated --anno 1 --threads $THREADS
