#!/usr/bin/env bash
  
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=01:00:00
#SBATCH --job-name=age_repeatmasker
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/lgladiseva/annotation_course/EDTA_annotation2"
INPUTDIR="/data/users/lgladiseva/annotation_course/EDTA_annotation2/assembly.fasta.mod.EDTA.anno"
SCRIPTDIR="/data/users/lgladiseva/annotation_course/EDTA_annotation2/scripts"

cd $WORKDIR

# download the perl script from github
wget -P $SCRIPTDIR https://raw.githubusercontent.com/4ureliek/Parsing-RepeatMasker-Outputs/master/parseRM.pl

# make it executable
chmod +x $SCRIPTDIR/parseRM.pl

module add BioPerl/1.7.8-GCCcore-10.3.0
perl $SCRIPTDIR/parseRM.pl -i $INPUTDIR/assembly.fasta.mod.out -l 50,1 -v > $INPUTDIR/parsed_TE_divergence_output.tsv