#!/bin/bash
##### INFO ######
# This script supposes to:
# 1. run benchmarks inside the container by means of udocker
#    List of available to run containes: $> udocker ps
#
# VKozlov @23-Mar-2018
#
# udocker: https://github.com/indigo-dc/udocker
#
################

####### MAIN CONFIG #######
NUMGPUS=1                                                 # ForHLR2 has 4 GTX980 on one node => use NUMGPUS=4
USERScript="testscript-mx.py"                            # user program to run
UCONTAINER="mxnet_130_gpu_cu90"                           # container to use
#USERScript="testscript-tf.py"                             # user program to run
#UCONTAINER="tf-mnist-cd"                         # container to use
#USERScript="download_check.py"                             # user program to run
#UCONTAINER="rpkitdev-gpu"
#UCONTAINER="vykozlov/deep-oc-retinopathy_kit_dev:gpu"       # container to use
#--------------------------
UDOCKER_DIR="$PROJECT/.udocker"                           # udocker main directory.
#UDOCKERSETUP="--execmode=F3 --nvidia"                     # udocker setup settings.
#UDOCKERSETUP="--execmode=P1"
UDOCKERSETUP="--nvidia"
HOSTDIR=$PROJECT                                          # directory at your host to mount inside the container.
USERScriptDirHost=$HOSTDIR/workspace/udocker-example      # location of the user program (host)
DIRINCONTAINER="/home"                                    # mount point inside container
SCRIPTDIR=${USERScriptDirHost//$HOSTDIR/$DIRINCONTAINER}  # replace host path with one in container
SCRIPT="$USERScript"                           # user program to run
##########################

echo "=> Doing the setup, $UDOCKERSETUP"
udocker setup $UDOCKERSETUP ${UCONTAINER}

echo "==================================="
echo "=> udocker container: $UCONTAINER"
echo "=> Running on $(hostname) ..."
echo "==================================="

# For udocker debugging specify "udocker -D run " + the rest
if [ $NUMGPUS -ge 2 ]; then
    for (( i=0; i<$NUMGPUS; i++ ));
    do 
        udocker run --volume=$HOSTDIR:$DIRINCONTAINER --env="CUDA_VISIBLE_DEVICES=$i" --workdir=$DIRINCONTAINER ${UCONTAINER} $SCRIPT &
    done
    wait  ### IMPORTANT !!!
else
    udocker run --volume=$USERScriptDirHost:$DIRINCONTAINER --workdir=$DIRINCONTAINER ${UCONTAINER} python /home/$SCRIPT
fi
