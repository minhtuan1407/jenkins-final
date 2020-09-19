#!/bin/bash

docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull
docker stop $(docker ps -aq)

./nodejs/deploy-nodejs.sh
./python/deploy-python.sh
