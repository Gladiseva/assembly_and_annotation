#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury_evaluation
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course
INPUT_DIR=$WORK_DIR/assembly_out
OUTPUT_DIR=$WORK_DIR/evaluation/merqury
READS_DIR=$WORK_DIR/PacBioHiFi/PacBioHiFi_trimmed.fastq.gz
CONTAINER_DIR=/containers/apptainer/merqury_1.3.sif

export MERQURY="/usr/local/share/merqury"

mkdir -p $OUTPUT_DIR 
Count k-mer frequencies
# k=18 based on  output
apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
meryl k=18 count $READS_DIR output $OUTPUT_DIR/genome.meryl

cd $OUTPUT_DIR

apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
sh $MERQURY/merqury.sh $OUTPUT_DIR/genome.meryl $INPUT_DIR/flye/assembly.fasta flye

apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
sh $MERQURY/merqury.sh $OUTPUT_DIR/genome.meryl $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa hifiasm

apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
sh $MERQURY/merqury.sh $OUTPUT_DIR/genome.meryl $INPUT_DIR/lja/assembly.fasta lja
