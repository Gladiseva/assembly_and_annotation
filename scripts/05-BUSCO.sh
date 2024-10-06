#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=busco
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course
INPUT_DIR=$WORK_DIR/assembly_out
OUTPUT_DIR=$WORK_DIR/evaluation

mkdir -p $OUTPUT_DIR/busco_flye
mkdir -p $OUTPUT_DIR/busco_hifiasm
mkdir -p $OUTPUT_DIR/busco_lja
mkdir -p $OUTPUT_DIR/busco_trinity

module load BUSCO/5.4.2-foss-2021a

#busco -i $INPUT_DIR/flye/assembly.fasta -m genome --lineage_dataset brassicales_odb10 --cpu 4 -o $OUTPUT_DIR/busco_flye -f
busco -i $INPUT_DIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.fa -m genome --lineage_dataset brassicales_odb10 --cpu 4 -o $OUTPUT_DIR/busco_hifiasm -f
#busco -i $INPUT_DIR/lja/assembly.fasta -m genome --lineage_dataset brassicales_odb10 --cpu 4 -o $OUTPUT_DIR/busco_lja -f
#busco -i $INPUT_DIR/trinity.Trinity.fasta -m transcriptome --lineage_dataset brassicales_odb10 --cpu 4 -o $OUTPUT_DIR/busco_trinity -f