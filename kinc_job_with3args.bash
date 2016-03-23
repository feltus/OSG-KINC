#!/bin/bash

input_matrix_targz=$1
input_matrix=$2
job_index_input=$3

echo "Loading modules ..."
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/bash
module load sqlite/3.8.11.1
module load libgfortran
module load lapack
module load gcc/4.9.2
module load mixmodlib
module load gsl
echo "Module loading done."

tar -xzf $input_matrix_targz
chmod +x kinc

START_TS=`date +'%s'`

./kinc similarity --ematrix $input_matrix --rows 10000 --cols 200 --headers --method sc --omit_na --na_val NA --clustering mixmod --criterion ICL --min_obs 30 --num_jobs 10000 --job_index $job_index_input > kinc.out.$job_index_input
tar czf clusters-sc$job_index_input.tar.gz clusters-sc
RC=$?

END_TS=`date +'%s'`
DIFF_TS=$(($END_TS - $START_TS))
if [ $DIFF_TS -lt 300 ]; then
    sleep 5m
fi

exit $RC

