#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=TEsorter
#SBATCH --partition=pibu_el8

ASSEMBLY_DIR=/data/users/lgladiseva/assembly_course/assembly_out/lja/assembly.fasta
WORK_DIR=/data/users/lgladiseva/annotation_course
CONTAINER_DIR=/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif

cd $WORK_DIR/EDTA_annotation2

apptainer exec -C -H $WORK_DIR -H ${pwd}:/work \
--writable-tmpfs -u $CONTAINER_DIR TEsorter /data/users/lgladiseva/annotation_course/EDTA_annotation2/assembly.fasta.mod.EDTA.raw/assembly.fasta.mod.LTR.intact.raw.fa -db rexdb-plant