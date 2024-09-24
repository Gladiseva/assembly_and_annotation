#!/bin/bash
  
#SBATCH --time=2:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=run_fastp
#SBATCH --partition=pibu_el8

module load fastp/0.23.4-GCC-10.3.0

ILLUMINA_RNASEQ_FILE_1="/data/users/lgladiseva/assembly_course/RNAseq_Sha/ERR754081_1.fastq.gz"
ILLUMINA_RNASEQ_FILE_2="/data/users/lgladiseva/assembly_course/RNAseq_Sha/ERR754081_2.fastq.gz"
PACBIO_HIFI_FILE="/data/users/lgladiseva/assembly_course/Had-6b/ERR11437317.fastq.gz"
ILLUMINA_OUTPUT_DIR="/data/users/lgladiseva/assembly_course/IlluminaRNAseq"
PACBIO_OUTPUT_DIR="/data/users/lgladiseva/assembly_course/PacBioHiFi"

# Create output directories if they don't exist
mkdir -p ${ILLUMINA_OUTPUT_DIR}
mkdir -p ${PACBIO_OUTPUT_DIR}

# Run fastp on Illumina RNAseq data (paired-end)
fastp \
    -i ${ILLUMINA_RNASEQ_FILE_1} \
    -I ${ILLUMINA_RNASEQ_FILE_2} \
    -o ${ILLUMINA_OUTPUT_DIR}/filtered_trimmed_RNAseq_1.fastq.gz \
    -O ${ILLUMINA_OUTPUT_DIR}/filtered_trimmed_RNAseq_2.fastq.gz \
    --detect_adapter_for_pe \
    --cut_by_quality3 \
    --cut_mean_quality 30 \
    --length_required 30 \
    --thread 4 \
    --html ${ILLUMINA_OUTPUT_DIR}/fastp_report.html \
    --json ${ILLUMINA_OUTPUT_DIR}/fastp_report.json

# Run fastp on PacBio HiFi data (without filtering, only generating stats)
fastp \
    -i ${PACBIO_HIFI_FILE} \
    -o ${PACBIO_OUTPUT_DIR}/PacBioHiFi_trimmed.fastq.gz \
    --disable_length_filtering \
    --thread 4 \
    --html ${PACBIO_OUTPUT_DIR}/fastp_report.html \
    --json ${PACBIO_OUTPUT_DIR}/fastp_report.json

echo "fastp analysis completed."