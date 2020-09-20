#!/bin/bash

docker pull minhtuan9801/nodejs
docker run -d --rm --name nodejs-app --net=host -e DOCKER_TAG=$DOCKER_TAG minhtuan9801/nodejs:$DOCKER_TAG
