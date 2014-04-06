#!/bin/bash

if [ $# -lt 2 ]
  then
    echo "Usage: resourcemanager_run.sh <namenode_ip_address> <docker_image_name>"
    exit
fi
docker run -link namenode:namenode -e namenode_ip=$1 -e NODE_TYPE=resourcemanager -dns 127.0.0.1 -p 8088:8088 -p 8032:8032 -p 50060:50060 -p 8081:8081 -p 8030:8030 -p 8050:8050 -p 8025:8025 -p 8141 -p 19888:19888 -p 45454 -p 10020:10020 -p 22  -name resourcemanager -h resourcemanager -i -t $2
