#!/bin/bash
JOB2RUN=./job_udocker.sh
NJOB=3
for j in $(seq 1 $NJOB)
do 
    echo "Submitting job $j out of $NJOB.."
    msub -N udocker -l nodes=1:ppn=1:visu,walltime=3:00:00 $JOB2RUN
    sleep 1s
done
