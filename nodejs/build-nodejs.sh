#!/bin/bash
docker build -t nodejs ./nodejs/.
docker tag nodejs minhtuan9801/nodejs:$DOCKER_TAG
