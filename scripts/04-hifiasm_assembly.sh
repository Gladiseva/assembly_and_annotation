#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=32
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=hifiasm_asmbly
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
CONTAINER_DIR=/containers/apptainer/hifiasm_0.19.9.sif
HIFI_READS=$WORKDIR/PacBioHiFi/PacBioHiFi_trimmed.fastq.gz
OUTDIR=$WORKDIR/assembly_out/hifiasm

mkdir -p $OUTDIR

# Use Apptainer to run Hifiasm
apptainer exec --bind $WORKDIR $CONTAINER_DIR hifiasm -o $OUTDIR/PacBioHiFi_trimmed.asm -t 32 $HIFI_READS

# Change the output to fasta format
awk '/^S/{print ">"$2;print $3}' $OUTDIR/PacBioHiFi_trimmed.asm.bp.p_ctg.gfa > $OUTDIR/PacBioHiFi_trimmed.asm.bp.p_ctg.fa
