#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=gfastats_analysis
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
OUTDIR=$WORKDIR/assembly_out

GFASTATS_OUTDIR=$WORKDIR/gfastats_results
mkdir -p $GFASTATS_OUTDIR

HIFIASM_ASM=$OUTDIR/hifiasm/PacBioHiFi_trimmed.asm.bp.p_ctg.gfa
LJA_ASM=$OUTDIR/lja/k501/disjointigs.fasta
FLYE_ASM=$OUTDIR/00-assembly/draft_assembly.fasta
TRINITY_ASM=$OUTDIR/trinity/both.fa

GFASTATS_CONTAINER=/containers/apptainer/gfastats_1.3.7.sif

apptainer exec $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/hifiasm_gfastats.txt $HIFIASM_ASM
apptainer exec $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/lja_gfastats.txt $LJA_ASM
apptainer exec $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/flye_gfastats.txt $FLYE_ASM
apptainer exec $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/trinity_gfastats.txt $TRINITY_ASM

echo "GFASTATS analysis completed. Results stored in $GFASTATS_OUTDIR"
