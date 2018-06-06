#!/usr/bin/env bash

NumGPUS=1
DATENOW=$(date +%y%m%d_%H%M%S)
SCRIPTDIR=$(dirname $0)

echo $0
echo "Params="$#
echo $@

if [ $# -ge 0 ]; then
    arr=("$@")
    for i in "${arr[@]}"; do
        [[ $i = *"--num_gpus"* ]]  && NumGPUS=${i#*=}
        [[ $i = *"--exec"* ]]      && ExecScript=${i#*=}
    done
fi

echo "NumGPUS="$NumGPUS
echo "ExecScript="$ExecScript

for (( i=0; i<$NumGPUS; i++ ));
do
    if [ $NumGPUS -ge 2 ]; then
        export CUDA_VISIBLE_DEVICES=$i
        echo "CUDA_VISIBLE_DEVICES="$CUDA_VISIBLE_DEVICES
    fi
    python $ExecScript > $SCRIPTDIR/$DATENOW-job_ngpus_$i.out
done
