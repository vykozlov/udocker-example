#!/usr/bin/env bash

NumGPUs=1

if [ $# -ge 0 ]; then
    for i in "${arr[@]}"; do
        [[ $i = *"--num_gpus"* ]]  && NumGPUs=${i#*=}
        [[ $i = *"--exec"* ]]      && ExecScript=${i#*=}
    done
fi

for (( i=0; i<$NumGPUs; i++ ));
do
    if [ $NumGPUs -ge 1 ]; then
        export CUDA_VISIBLE_DEVICES=$i
    fi
    python $ExecScript
done
