#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=nucmer_accession_comparison
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course/
OUTPUT_DIR=/data/users/lgladiseva/assembly_course/comparison_accessions
CONTAINER_DIR=/containers/apptainer/mummer4_gnuplot.sif

ASSEMBLY1=/data/users/lgladiseva/assembly_course/assembly_out/flye/assembly.fasta
ASSEMBLY2=/data/users/lgladiseva/assembly_course/assembly_out/flye/assembly_jazmin.fasta
ASSEMBLY3=/data/users/lgladiseva/assembly_course/assembly_out/flye/assembly_ruitong.fasta
ASSEMBLY4=/data/users/lgladiseva/assembly_course/assembly_out/flye/assembly_dario.fasta

mkdir -p $OUTPUT_DIR

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/assembly1_vs_assembly2.delta $ASSEMBLY1 $ASSEMBLY2

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $ASSEMBLY1 -Q $ASSEMBLY2 --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/assembly1_vs_assembly2_plot $OUTPUT_DIR/assembly1_vs_assembly2.delta

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/assembly1_vs_assembly3.delta $ASSEMBLY1 $ASSEMBLY3

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $ASSEMBLY1 -Q $ASSEMBLY3 --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/assembly1_vs_assembly3_plot $OUTPUT_DIR/assembly1_vs_assembly3.delta

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/assembly1_vs_assembly4.delta $ASSEMBLY1 $ASSEMBLY4

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $ASSEMBLY1 -Q $ASSEMBLY4 --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/assembly1_vs_assembly4_plot $OUTPUT_DIR/assembly1_vs_assembly4.delta

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/assembly2_vs_assembly3.delta $ASSEMBLY2 $ASSEMBLY3

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $ASSEMBLY2 -Q $ASSEMBLY3 --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/assembly2_vs_assembly3_plot $OUTPUT_DIR/assembly2_vs_assembly3.delta

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/assembly2_vs_assembly4.delta $ASSEMBLY2 $ASSEMBLY4

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $ASSEMBLY2 -Q $ASSEMBLY4 --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/assembly2_vs_assembly4_plot $OUTPUT_DIR/assembly2_vs_assembly4.delta

apptainer exec --bind /data $CONTAINER_DIR \
nucmer --threads 6 --mincluster 1000 --breaklen 1000 --delta $OUTPUT_DIR/assembly3_vs_assembly4.delta $ASSEMBLY3 $ASSEMBLY4

apptainer exec --bind /data $CONTAINER_DIR \
mummerplot -R $ASSEMBLY3 -Q $ASSEMBLY4 --fat --layout --filter --breaklen 1000 -t png --large -p $OUTPUT_DIR/assembly3_vs_assembly4_plot $OUTPUT_DIR/assembly3_vs_assembly4.delta
