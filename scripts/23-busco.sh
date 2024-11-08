#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=40G
#SBATCH --time=06:00:00
#SBATCH --job-name=busco
#SBATCH --partition=pibu_el8

WORK_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/final"
OUT_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/evaluation"
mkdir -p $OUT_DIR

PLOT_DIR="/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/BUSCO"
mkdir -p $PLOT_DIR

module load BUSCO/5.4.2-foss-2021a
module load SeqKit/2.6.1

# create file with the longest transcripts
seqkit fx2tab -nl $WORK_DIR/assembly.all.maker.fasta.all.maker.transcripts.fasta.renamed.filtered.fasta > $OUT_DIR/transcript_lengths.tsv
sort -k1,1 -k2,2nr $OUT_DIR/transcript_lengths.tsv | \
awk '{
    gene = gensub(/ .*/, "", "g", $1); # Assuming space separates gene ID
    if (gene != last_gene) {
        print $1;
        last_gene = gene;
    }
}' > $OUT_DIR/longest_transcripts.txt

seqkit grep -f $OUT_DIR/longest_transcripts.txt $WORK_DIR/assembly.all.maker.fasta.all.maker.transcripts.fasta.renamed.filtered.fasta > $WORK_DIR/assembly.all.maker.fasta.all.maker.transcripts.fasta.renamed.filtered.longest.fasta

# create file with the longest proteins
seqkit fx2tab -nl $WORK_DIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta > $OUT_DIR/protein_lengths.tsv
sort -k1,1 -k2,2nr $OUT_DIR/protein_lengths.tsv | \
awk '{
    gene = gensub(/ .*/, "", "g", $1); # Assuming space separates gene ID
    if (gene != last_gene) {
        print $1;
        last_gene = gene;
    }
}' > $OUT_DIR/longest_proteins.txt

seqkit grep -f $OUT_DIR/longest_proteins.txt $WORK_DIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta > $WORK_DIR/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.longest.fasta                                                                                                                                           1,1           Top
