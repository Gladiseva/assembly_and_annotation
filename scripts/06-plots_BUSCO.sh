#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=busco_plots
#SBATCH --partition=pibu_el8

WORK_DIR=/data/users/lgladiseva/assembly_course
INPUT_DIR=$WORK_DIR/evaluation
OUTPUT_DIR=$WORK_DIR/busco_plots

module load BUSCO/5.4.2-foss-2021a

mkdir -p $OUTPUT_DIR

cp $INPUT_DIR/busco_flye/short_summary.specific.brassicales_odb10.busco_flye.txt $OUTPUT_DIR/.
cp $INPUT_DIR/busco_hifiasm/short_summary.specific.brassicales_odb10.busco_hifiasm.txt $OUTPUT_DIR/.
cp $INPUT_DIR/busco_lja/short_summary.specific.brassicales_odb10.busco_lja.txt $OUTPUT_DIR/.
cp $INPUT_DIR/busco_trinity/short_summary.specific.brassicales_odb10.busco_trinity.txt $OUTPUT_DIR/.

# download the generate_plot.py script from  GitHub
cd $OUTPUT_DIR
wget https://gitlab.com/ezlab/busco/-/raw/master/scripts/generate_plot.py

python3 generate_plot.py -wd $OUTPUT_DIR

