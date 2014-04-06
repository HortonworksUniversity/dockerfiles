#!/bin/bash

if [ $# -lt 2 ]
  then
    echo "Usage: hiveserver_run.sh <namenode_ip_address> <docker_image_name>"
    exit
fi
docker run -link namenode:namenode -e namenode_ip=$1 -e NODE_TYPE=hiveserver-tez -dns 127.0.0.1 -p 11000:11000 -p 2181 -p 50111:50111 -p 9083 -p 10000 -p 9999:9999 -p 9933:9933 -p 22  -name hiveserver-tez -h hiveserver -i -t $2 bash
