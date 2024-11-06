#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=TE_cg
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/annotation_course
CONTAINERDIR=/data/courses/assembly-annotation-course/containers2/TEsorter_1.3.0.sif

cd $WORKDIR/EDTA_annotation2


module load SeqKit/2.6.1

seqkit grep -r -p "Copia" assembly.fasta.mod.EDTA.TElib.fa > Copia_sequences.fa
seqkit grep -r -p "Gypsy" assembly.fasta.mod.EDTA.TElib.fa > Gypsy_sequences.fa

apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u $CONTAINERDIR TEsorter Copia_sequences.fa -db rexdb-plant
apptainer exec -C -H $WORKDIR -H ${pwd}:/work --writable-tmpfs -u $CONTAINERDIR TEsorter Gypsy_sequences.fa -db rexdb-plant