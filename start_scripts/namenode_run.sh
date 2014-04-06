#!/bin/bash

if [ $# -lt 1 ]
  then
    echo "Usage: namenode_run.sh  <docker_image_name>"
    exit
fi
docker run -dns 127.0.0.1 -p 50070:50070 -p 8020:8020 -e NODE_TYPE=namenode -name namenode -h namenode -i -t $1
