#!/bin/bash

docker inspect $(docker ps  | awk '{print $2}' | grep -v ID) | jq .[].RepoTags | cut -d ":" -f 2 | grep latest | cut -b -6 | head -1
