#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=06:00:00
#SBATCH --job-name=BLAST
#SBATCH --partition=pibu_el8

OUTDIR="/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/BLAST"
WORKDIR="/data/users/lgladiseva/annotation_course/gene_annotation/final"
REFDIR="/data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa"
MAKERBIN="/data/courses/assembly-annotation-course/CDS_annotation/softwares/Maker_v3.01.03/src/bin"

mkdir -p $OUTDIR

module load BLAST+/2.15.0-gompi-2021a

makeblastdb -in /data/courses/assembly-annotationcourse/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -dbtype prot

blastp -query $WORKDIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta -db $REFDIR -num_threads 10 -outfmt 6 -evalue 1e-10 -out $OUTDIR/blastp_output

cp $WORKDIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta $WORKDIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta.Uniprot
cp $WORKDIR/filtered.genes.renamed.final.gff3 $WORKDIR/filtered.genes.renamed.final.gff3.Uniprot
$MAKERBIN/maker_functional_fasta $REFDIR $OUTDIR/blastp_output $WORKDIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta > $WORKDIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta.Uniprot
$MAKERBIN/maker_functional_gff $REFDIR $OUTDIR/blastp_output $WORKDIR/filtered.genes.renamed.final.gff3 > $WORKDIR/filtered.genes.renamed.final.gff3.Uniprot