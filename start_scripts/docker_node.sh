#!/bin/bash

if [ $# -lt 3 ]
  then
    echo "Usage: workernode_run.sh <workernode_name> <namenode_ip_address> <docker_image_name>"
    exit
fi
docker run -v /lib/modules:/lib/modules -link namenode:namenode -e namenode_ip=$2 -e NODE_TYPE=workernode -dns 127.0.0.1 -p 8010 -p 50075 -p 50010 -p 50020 -p 45454 -p 8081 -p 22  -name $1 -h $1 -i -t $3
