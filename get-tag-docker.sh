#!/bin/bash

docker image list | cut -d ' ' -f 4 | grep latest | head -1
