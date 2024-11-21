#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=context
#SBATCH --partition=pibu_el8

# Download and build miniprot
if [ ! -d "miniprot" ]; then
    git clone https://github.com/lh3/miniprot
fi

cd miniprot
make clean
make
cd ..

# Add miniprot to PATH
export PATH=$(pwd)/miniprot:$PATH

# Run miniprot
miniprot -I --gff --outs=0.95 /data/users/lgladiseva/assembly_course/assembly_out/lja/assembly.fasta /data/users/lgladiseva/annotation_course/scripts/fragment_output.fa > miniprot_fragment_correction_fragment.fasta

miniprot -I --gff --outs=0.95 /data/users/lgladiseva/assembly_course/assembly_out/lja/assembly.fasta /data/users/lgladiseva/annotation_course/scripts/missing_output.fa > miniprot_fragment_correction_missing.fasta
