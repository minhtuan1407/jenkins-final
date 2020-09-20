#!/bin/bash

docker pull minhtuan9801/python
docker run -d --rm --name python-app --net=host -e DOCKER_TAG=$DOCKER_TAG minhtuan9801/python:$DOCKER_TAG
