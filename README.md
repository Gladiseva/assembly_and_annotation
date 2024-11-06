# Illumina RNA-Seq and PacBio HiFi Reads Data Analysis 🧬 

## Overview

This project involves analyzing two datasets:
1. **PacBio HiFi Reads**: Accession Had-6bn
2. **Illumina RNA-seq**: Accession RNAseq_Sha

## Part 1: Basic Read Statistics (FastQC) 📈  

Run FastQC on your FASTQ files using the following SLURM batch script:

Example:
```bash
sbatch ./scripts/01-run_fastqc.sh /path/to/accession/Had-6b/ERR11437317.fastq.gz
```


## Part 2: Filter and Trim Reads (fastp) ⚙️

Example:
```bash
sbatch ./scripts/02-run_fastp.sh
```

**Actions Taken:**
- **Illumina RNAseq Data**: Filtered and trimmed using specific parameters to address quality issues.
- **PacBio HiFi Data**: Analyzed without filtering to retain all reads and determine the total number of bases.

## Part 3: Perform k-mer counting 🪼 🔢
For PacBio HiFi Data Analysis, three assembly tools were utilized:

- **counting k-mers** (jellyfish count)
- **creating a histogram** (jellyfish histo)

Example:
```bash
sbatch ./scripts/03-kmer.sh
```

## Part 4: Assembly of Reads 🧩
For PacBio HiFi Data Analysis, three assembly tools were utilized:

- **Flye**
- **Hifiasm**
- **LJA**

For Illumina RNA-seq Data Analysis:
- **Trinity**

Example:
```bash
sbatch ./scripts/04-trinity_assembly.sh
sbatch ./scripts/04-hifi_assembly.sh
sbatch ./scripts/04-lja_assembly.sh
sbatch ./scripts/04_flye_assembly.sh
```

## Part 5: Assembly evaluation and comparing genomes 🔬📊
- **Assessing quality with BUSCO**
- **Assessing quality with QUAST** (with and without reference genome)
- **Assessing quality with merqury**

Example:
```bash
sbatch ./scripts/05-BUSCO.sh + ./scripts/06_plots_busco.sh
sbatch ./scripts/05-QUAST_no_reference.sh and ./scripts/05-QUAST_with_reference.sh
sbatch ./scripts/05-merqury_find_best_k.sh + ./scripts/05-merqury_evaluation.sh 
```

## Part 6: Comparing genomes ⚖️
- **Run nucmer and mummer**: compare the assembled genomes from flye, hifiasm and LJA against the Arabidopsis thaliana reference 🌱 and against each other 🔄.

Example:
```bash
sbatch ./scripts/07-comparison.sh
sbatch ./scripts/08-accession_comparison.sh
```

## Part 7: EDTA Transposable Element Annotation ✨🔀💥

For Transposable Element (TE) annotation, the EDTA pipeline was used to annotate repetitive elements in the PacBio HiFi Assembly (LJA).

Example:

```bash
# First clone repo
git clone https://github.com/oushujun/EDTA.git in $WORKDIR

# Second use EDTA_2.2.x.yml to create conda environment EDTA2
conda env create --name EDTA2 --file EDTA_2.2.x.yml

# Run script
sbatch ./scripts/09-edta_annotation.sh
```

**Actions:**
- Load Anaconda and activate the EDTA2 environment.
- Run the EDTA.pl script on the LJA assembly
- Transposable elements are annotated in the assembly, with gene masking using TAIR10 CDS data.

## Part 8: TE Analysis and Visualization Scripts 📊
```bash
10-sortTE.sh
```
Script 10: Sorts transposable elements (TEs) in the assembly output using the TEsorter container.

```bash
11-full_length_LTRs_identity.R
```
Script 11: Reads the GFF3 annotation of long terminal repeats (LTRs), identifies the most abundant superfamilies, filters out unwanted superfamilies

```bash
12-fai.sh
```
Script 12: Utilizes SAMtools to create an index (FAI) for the assembly FASTA file.

```bash
13-circle.R
```
Script 13: Generates a circos plot to visualize the density of TEs across the top 20 longest scaffolds, defining colors for different superfamilies and adding a legend for clarity.

To add clades run:
```bash
15-copia_and_gypsy.sh + 16_circle_gypsy_copia.R
```

## Part 9: Gene Annotation with MAKER 🧬📝
The 14-maker.sh script runs the MAKER pipeline to annotate genes on the assembled PacBio HiFi genome.

Example:
```bash
sbatch ./scripts/14-maker.sh
```

## Part 10: Transposable Element Dynamics and Visualization ✨📊
This part involves analyzing the dynamics of transposable elements (TEs) in assembled genome (parsing and visualizing the RepeatMasker output, estimating TE divergence over time, and generating plots to understand TE dynamics in terms of sequence divergence).

Overview
- **TE Dynamics Analysis** ```bash(scripts/17-te_dynamics.sh)``` 🧬🔍: This script processes the RepeatMasker outputs, calculates the divergence of TEs, and prepares the data for visualization.
- **TE Divergence Visualization** ```bash(scripts/18-plot_div.R)``` 📈🎨: This R script visualizes the TE dynamics, specifically focusing on the age (divergence) of the transposable elements.
