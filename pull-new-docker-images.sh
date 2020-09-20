#!/bin/bash

if grep -Fqe "Image is up to date" << EOF
`docker images | awk '(NR>1) && ($2!~/none/) {print $1":"$2}' | xargs -L1 docker pull`
EOF
then
    echo "Notthing to update"
    docker system prune --force
else
    echo "Newer image exist, redeploy!"
    docker stop $(docker ps -aq)
    ./nodejs/deploy-nodejs.sh
    ./python/deploy-python.sh
fi
