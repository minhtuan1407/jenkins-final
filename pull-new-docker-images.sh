#!/bin/bash

if grep -Fqe "Image is up to date for minhtuan9801/python:latest" << EOF
`docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull`
EOF
then
    echo "Python don't need to update"
else
    echo "Newer python image exist, redeploy!"
    docker stop $(docker ps -aq)
    ./python/deploy-python.sh
fi

if grep -Fqe "Image is up to date for minhtuan9801/nodejs:latest" << EOF
`docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull`
EOF
then
    echo "Nodejs don't need to update"
else
    echo "Newer nodejs image exist, redeploy!"
    docker stop $(docker ps -aq)
    ./nodejs/deploy-nodejs.sh
fi
