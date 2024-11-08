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

## create busco plot
cp /data/users/lgladiseva/annotation_course/scripts/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/transcripts/short_summary.specific.brassicales_odb10.transcripts.txt $PLOT_DIR/.
cp /data/users/lgladiseva/annotation_course/scripts/data/users/lgladiseva/annotation_course/gene_annotation/evaluation/proteins/short_summary.specific.brassicales_odb10.proteins.txt $PLOT_DIR/.

cd $PLOT_DIR
wget https://gitlab.com/ezlab/busco/-/raw/master/scripts/generate_plot.py

python3 generate_plot.py -wd $PLOT_DIR
                                                                                                                                                                                          1,1           Top
