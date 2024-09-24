# RNA-Seq and PacBio HiFi Data Analysis

## Overview

This project involves analyzing two datasets:
1. **PacBio HiFi Reads**: Accession Had-6bn
2. **Illumina RNA-seq**: Accession RNAseq_Sha

## Part 1: Basic Read Statistics (FastQC)

Run FastQC on your FASTQ files using the following SLURM batch script:

Example:
```bash
sbatch ./scripts/01-run_fastqc.sh /data/users/lgladiseva/assembly_course/Had-6b/ERR11437317.fastq.gz
```


## Part 2: Filter and Trim Reads (fastp)

Example:
```bash
sbatch ./scripts/02-run_fastp.sh
```

**Actions Taken:**
- **Illumina RNAseq Data**: Filtered and trimmed using specific parameters to address quality issues.
- **PacBio HiFi Data**: Analyzed without filtering to retain all reads and determine the total number of bases.


