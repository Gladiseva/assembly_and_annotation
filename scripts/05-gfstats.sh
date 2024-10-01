#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00
#SBATCH --job-name=gfastats_assembly_analysis
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/assembly_course
OUTDIR=$WORKDIR/assembly_out

GFASTATS_OUTDIR=$WORKDIR/gfastats_results
mkdir -p $GFASTATS_OUTDIR

HIFIASM_DIR=$OUTDIR/hifiasm
HIFIASM_ASM=$HIFIASM_DIR/PacBioHiFi_trimmed.asm.bp.p_ctg.gfa

FLYE_DIR=$OUTDIR/flye
FLYE_FASTA=$FLYE_DIR/assembly.fasta
FLYE_GFA=$FLYE_DIR/assembly_graph.gfa

GFASTATS_CONTAINER=/containers/apptainer/gfastats_1.3.7.sif

# Run gfastats for hifiasm assembly GFA file
apptainer exec --bind $WORKDIR $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/hifiasm_gfastats.txt -a $HIFIASM_ASM --discover-paths

# Run gfastats for Flye assembly FASTA file
apptainer exec --bind $WORKDIR $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/flye_assembly_stats.txt -a $FLYE_FASTA

# Run gfastats for Flye assembly GFA file
apptainer exec --bind $WORKDIR $GFASTATS_CONTAINER gfastats -o $GFASTATS_OUTDIR/flye_graph_stats.txt -a $FLYE_GFA --discover-paths

echo "GFASTATS analysis for both hifiasm and Flye completed. Results stored in $GFASTATS_OUTDIR"
