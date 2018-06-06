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
NUMGPUS=4                                                 # ForHLR2 have 4 GTX980 on one node!
USERScript="testscript-mx.py"                             # user program to run
UCONTAINER="mxpy120_gpu_cuda9"                            # container to use
#USERScript="testscript-tf.py"                            # user program to run
#UCONTAINER="tf160-gpu"                                   # container to use
#--------------------------
UDOCKER_DIR="$PROJECT/.udocker"                           # udocker main directory.
UDOCKERSETUP="--execmode=F3 --nvidia"                     # udocker setup settings.
HOSTDIR=$PROJECT                                          # directory at your host to mount inside the container.
USERScriptDirHost=$HOSTDIR/workspace/udocker-example      # location of the user program (host)
DIRINCONTAINER="/home"                                    # mount point inside container
SCRIPTDIR=${USERScriptDirHost//$HOSTDIR/$DIRINCONTAINER}  # replace host path with one in container
SCRIPT="$SCRIPTDIR/script_ngpus.sh --num_gpus=$NUMGPUS --exec=$SCRIPTDIR/$USERScript"     # user program to run
##########################

echo "=> Doing the setup"
udocker setup $UDOCKERSETUP ${UCONTAINER}

echo "==================================="
echo "=> udocker container: $UCONTAINER"
echo "=> Running on $(hostname) ..."
echo "==================================="

# For udocker debugging specify "udocker -D run " + the rest
udocker run --volume=$HOSTDIR:$DIRINCONTAINER --workdir=$DIRINCONTAINER ${UCONTAINER} $SCRIPT
