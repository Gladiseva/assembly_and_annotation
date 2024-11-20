#!/usr/bin/env bash
  
#SBATCH --time=1-0
#SBATCH --mem=12G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --job-name=prep_omark
#SBATCH --partition=pibu_el8

protein_input=/data/users/lgladiseva/annotation_course/gene_annotation/final/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta
WORK_DIR=/data/users/lgladiseva/annotation_course/gene_annotation/final
protein_fai=/data/users/lgladiseva/annotation_course/gene_annotation/final/assembly.all.maker.fasta.all.maker.proteins.fasta.renamed.filtered.fasta.fai
OUT_DIR=/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/omark
input_file=/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/omark/all_isoforms.txt
output_file=/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/omark/all_isoforms_splice.txt

cd $OUT_DIR
#get isoform list
cut -f1 $protein_fai > all_isoforms.txt
# create an associative array to store isoforms per gene
declare -A gene_map

# Read each line from the input file
while IFS= read -r protein_id; do
    # Extract gene prefix (part before "-R")
    gene_prefix=$(echo "$protein_id" | sed -E 's/(-R.*)//')

    # Append protein ID to the corresponding gene key
    if [[ -z "${gene_map[$gene_prefix]}" ]]; then
        gene_map[$gene_prefix]="$protein_id"
    else
        gene_map[$gene_prefix]+=";$protein_id"
    fi
done < "$input_file"

# Write the grouped isoforms to the output file
> "$output_file"  # Clear the file if it exists
for gene in "${!gene_map[@]}"; do
    echo "${gene_map[$gene]}" >> "$output_file"
done