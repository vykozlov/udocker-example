
A few scripts showing how to use udocker with Docker hub images (e.g. Tensorflow, MXNet)

Official TensorFlow Docker images from https://hub.docker.com/r/tensorflow/tensorflow/tags/

Example how to use official TensorFlow images with `udocker`:
1. install udocker in your preferred directory:
```
$> curl https://raw.githubusercontent.com/mariojmdavid/udocker/devel/udocker.py > udocker
$> chmod u+rx ./udocker
$> ./udocker install 
```
2. look into `udocker_pull.sh` script and specify which TensorFlow you want to pull. Note the name of the created container. List of available containers is given by `udocker ps`
```
$> ./udocker_pull.sh tensorflow/tensorflow:1.7.0-gpu
```
or just
```
$> ./udocker_pull.sh
```    
(default is set in udocker_pull.sh, e.g. DEFAULTIMG=tensorflow/tensorflow:1.6.0-gpu)"

3. have a look into `job_udocker.sh` to adjust e.g. what example script `testscript-tf.py` or `testscript-mx.py` to run.
Run the script with the proper udocker container name (check with `udocker ps`).

Other important variables to check in the script:

UDOCKER_DIR="$PROJECT/.udocker"                           - udocker main directory.

HOSTDIR=$PROJECT                                          - directory at your host to mount inside the container.

USERScriptDirHost=$HOSTDIR/workspace/udocker-example      - location of the user program (host)

DIRINCONTAINER="/home"                                    - mount point inside container

