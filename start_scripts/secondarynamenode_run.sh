#!/bin/bash

if [ $# -lt 2 ]
  then
    echo "Usage: secondarynamenode_run.sh <namenode_ip_address> <docker_image_name>"
    exit
fi
docker run -link namenode:namenode -e namenode_ip=$1 -dns 127.0.0.1 -p 50090:50090 -p 22  -e NODE_TYPE=secondarynamenode -name secondarynamenode -h secondarynamenode -i -t $2
