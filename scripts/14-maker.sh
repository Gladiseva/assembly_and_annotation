#!/usr/bin/env bash
  
#SBATCH --time=4-0
#SBATCH --mem=64G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=50
#SBATCH --job-name=maker
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/lgladiseva/annotation_course"
OUTDIR="$WORKDIR/gene_annotation"
CONTAINERDIR="/data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif"
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
REPEATMASKER_DIR="/data/courses/assembly-annotation-course/CDS_annotation/softwares/RepeatMasker"
export PATH=$PATH:$REPEATMASKER_DIR

mkdir -p $OUTDIR
cd $OUTDIR

# apptainer exec --bind $WORKDIR $CONTAINERDIR maker -CTL

module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a

mpiexec --oversubscribe -n 50 apptainer exec \
--bind $SCRATCH:/TMP --bind $COURSEDIR --bind $WORKDIR --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR $CONTAINERDIR \
maker -mpi --ignore_nfs_tmp -TMP /TMP maker_opts.ctl maker_bopts.ctl maker_evm.ctl maker_exe.ctl

                                                                                                                                                                                          1,1           Top
