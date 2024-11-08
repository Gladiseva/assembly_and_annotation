#!/usr/bin/env bash
  
#SBATCH --time=1-10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=back_ann
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/lgladiseva/annotation_course/gene_annotation
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
UNIPROT=$COURSEDIR/data/uniprot/uniprot_viridiplantae_reviewed.fa
BLAST=$WORKDIR/evaluation/BLAST/blastp_output
PROTEINS=$WORKDIR/final/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=$WORKDIR/final/filtered.genes.renamed.final.gff3

cp $PROTEINS $WORKDIR/final/maker_proteins.fasta.Uniprot
cp $FILTERED $WORKDIR/final/filtered.maker.gff3.Uniprot

$MAKERBIN/maker_functional_fasta $UNIPROT $BLAST $PROTEINS > $WORKDIR/final/maker_proteins.fasta.Uniprot
$MAKERBIN/maker_functional_gff $UNIPROT $BLAST $FILTERED > $WORKDIR/final/filtered.maker.gff3.Uniprot