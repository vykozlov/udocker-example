#!/bin/bash
JOB2RUN=./job_udocker.sh
NJOB=1
for j in $(seq 1 $NJOB)
do 
    echo "Submitting job $j out of $NJOB.."
    #msub -N udocker -I -l nodes=1:ppn=1:visu,walltime=3:00:00
    msub -N udocker -l nodes=1:ppn=1:visu,walltime=3:00:00 $JOB2RUN
    #msub -N udocker -l nodes=1:ppn=1:visu,walltime=3:00:00 $PROJECT/workspace/udocker-example/_par_out.sh
    sleep 1s
done
