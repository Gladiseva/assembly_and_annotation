#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=quast_with_reference
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course
INPUT_DIR=$WORK_DIR/assembly_out
OUTPUT_DIR=$WORK_DIR/evaluation
REFERENCE_DIR=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
GENES_DIR=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
CONTAINER_DIR=/containers/apptainer/quast_5.2.0.sif

mkdir -p $OUTPUT_DIR/quast_with_reference

ASSEMBLIES=(
    "$INPUT_DIR/flye/assembly.fasta"
    "$INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa"
    "$INPUT_DIR/lja/assembly.fasta"
)

LABELS="flye,hifiasm,lja"

apptainer exec --bind /data $CONTAINER_DIR \
quast.py \
    -o $OUTPUT_DIR/quast_with_reference \
    -r $REFERENCE_DIR \
    --features $GENES_DIR \
    --threads 4 \
    --labels $LABELS \
    --eukaryote \
    --no-sv \
    "${ASSEMBLIES[@]}"

