#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=nucmer_comparison
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course/
INPUT_DIR=/data/users/lgladiseva/assembly_course/assembly_out
OUTPUT_DIR=/data/users/lgladiseva/assembly_course/comparison
REFERENCE_DIR=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
CONTAINER_DIR=/containers/apptainer/mummer4_gnuplot.sif

mkdir -p $OUTPUT_DIR

# assembly vs reference
apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/flye.delta $REFERENCE_DIR $INPUT_DIR/flye/assembly.fasta

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/hifiasm.delta $REFERENCE_DIR $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/lja.delta $REFERENCE_DIR $INPUT_DIR/lja/assembly.fasta

# mummerplots
apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $REFERENCE_DIR -Q $INPUT_DIR/flye/assembly.fasta --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/flye_plot $OUTPUT_DIR/flye.delta

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $REFERENCE_DIR -Q $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/hifiasm_plot $OUTPUT_DIR/hifiasm.delta

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $REFERENCE_DIR -Q $INPUT_DIR/lja/assembly.fasta --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/lja_plot $OUTPUT_DIR/lja.delta

# assemblies against each other
apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/flye_vs_hifiasm.delta $INPUT_DIR/flye/assembly.fasta $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa
apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
mummerplot -R $INPUT_DIR/flye/assembly.fasta -Q $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/flye_vs_hifiasm_plot $OUTPUT_DIR/flye_vs_hifiasm.delta

apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/flye_vs_lja.delta $INPUT_DIR/flye/assembly.fasta $INPUT_DIR/lja/assembly.fasta
apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
mummerplot -R $INPUT_DIR/flye/assembly.fasta -Q $INPUT_DIR/lja/assembly.fasta --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/flye_vs_lja_plot $OUTPUT_DIR/flye_vs_lja.delta

apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/hifiasm_vs_lja.delta $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa $INPUT_DIR/lja/assembly.fasta
apptainer exec --bind $WORK_DIR $CONTAINER_DIR \
mummerplot -R $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa -Q $INPUT_DIR/lja/assembly.fasta --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/hifiasm_vs_lja_plot $OUTPUT_DIR/hifiasm_vs_lja.delta
