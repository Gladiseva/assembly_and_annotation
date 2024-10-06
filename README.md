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
sbatch ./scripts/05-merqury.sh
```
- **Comparing genomes:** nucmer and mummer
- 
  Example:
```bash
sbatch ./scripts/07_comparison.sh
```
