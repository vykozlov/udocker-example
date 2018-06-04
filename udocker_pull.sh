#!/bin/bash
##### INFO ######
# This script supposes to:
# 1. download a Docker image (e.g. Tensorflow)
# 2. create corresponding udocker container
#
# VKozlov @18-May-2018
#
# udocker: https://github.com/indigo-dc/udocker
#
################

### MAIN CONFIG ###

UDOCKER_DIR="$PROJECT/.udocker"  # udocker main directory.

# Default settings. Will be overwritten from the command line (preferred way!)
DEFAULTIMG="tensorflow/tensorflow:1.6.0-gpu"
#DEFAULTIMG="mxnet/python:1.2.0_gpu_cuda9"
if [ $# -eq 0 ]; then
    DOCKERIMG=$DEFAULTIMG
elif [ $# -eq 1 ]; then
    DOCKERIMG=$1
else
    echo "#############################################################"
    echo "#  ERROR! Wrong execution. Either run as"
    echo "#  $> $0 DOCKERIMG (example: $0 tensorflow/tensorflow:1.7.0-gpu)"
    echo "#  or just"
    echo "#  $> $0 (default is set in $0, e.g. DEFAULTIMG=tensorflow/tensorflow:1.6.0-gpu)"
    echo "#############################################################"
    exit 1
fi

# Deduce DOCKERTAG from DOCKERIMG
DOCKERTAG=${DOCKERIMG#*:}

##########################

[[ $DOCKERIMG = *"mxnet"* ]]  && UPREFFIX="mx"
[[ $DOCKERIMG = *"tensorflow"* ]]  && UPREFFIX="tf"
[[ $DOCKERIMG = *"python"* ]]  && UPREFFIX=$UPREFFIX"py"

UCONTAINER="$UPREFFIX$DOCKERTAG"
UCONTAINER="${UCONTAINER//./}"

IFExist=$(udocker ps |grep "'$UCONTAINER'")
if [ ${#IFExist} -le 1 ]; then
    echo "=> Trying to pull the Docker Image: $DOCKERIMG"
    udocker pull $DOCKERIMG
    echo "=> Creating Container ${UCONTAINER}"
    if (udocker create --name=${UCONTAINER} ${DOCKERIMG}); then
       echo "########################################"
       echo "  contrainer $UCONTAINER created       "
       echo "  note the name and use it for jobs    "
       echo "########################################"    
    else
       echo "###########################################"
       echo "  Something went WRONG !!!  "
       echo "  Are you sure that:         "
       echo "  - docker image name is correct?"
       echo "  - udocker is installed??       "
       echo "###########################################"
       exit 1
    fi
else
    echo "###########################################"
    echo "  contrainer $UCONTAINER already exists!  "
    echo "  note the name and use it for jobs       "
    echo "###########################################"
fi
