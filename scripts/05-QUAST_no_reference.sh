#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=quast_no_reference
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course
INPUT_DIR=$WORK_DIR/assembly_out
OUTPUT_DIR=$WORK_DIR/evaluation
CONTAINER_DIR=/containers/apptainer/quast_5.2.0.sif

mkdir -p $OUTPUT_DIR/quast_no_reference

ASSEMBLIES=(
    "$INPUT_DIR/flye/assembly.fasta"
    "$INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa"
    "$INPUT_DIR/lja/assembly.fasta"
)

LABELS="flye,hifiasm,lja"

apptainer exec --bind /data $CONTAINER_DIR \
quast.py \
    -o $OUTPUT_DIR/quast_no_reference \
    --est-ref-size 130000000 \
    --threads 4 \
    --labels $LABELS \
    --eukaryote \
    --no-sv \
    "${ASSEMBLIES[@]}"
