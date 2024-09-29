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

HIFIASM_ASM=$OUTDIR/hifiasm/ERR11437354_fp.asm.bp.p_ctg.fa
LJA_ASM=$OUTDIR/lja/ERR11437354_fp.asm.fasta 
FLYE_ASM=$OUTDIR/00-assembly/assembly.fasta
TRINITY_ASM=$OUTDIR/trinity/Trinity.fasta

module load Gfastats/1.3.6-foss-2020a

gfastats -o $GFASTATS_OUTDIR/hifiasm_gfastats.txt $HIFIASM_ASM
gfastats -o $GFASTATS_OUTDIR/lja_gfastats.txt $LJA_ASM
gfastats -o $GFASTATS_OUTDIR/flye_gfastats.txt $FLYE_ASM
gfastats -o $GFASTATS_OUTDIR/trinity_gfastats.txt $TRINITY_ASM

echo "GFASTATS analysis completed. Results stored in $GFASTATS_OUTDIR"
