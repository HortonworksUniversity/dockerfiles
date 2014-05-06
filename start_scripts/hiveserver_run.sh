#!/bin/bash

if [ $# -lt 2 ]
  then
    echo "Usage: hiveserver_run.sh <namenode_ip_address> <docker_image_name>"
    exit
fi
docker run -link namenode:namenode -e namenode_ip=$1 -e NODE_TYPE=hiveserver -dns 127.0.0.1 -p 11000:11000 -p 50010 -p 50020 -p 50075 -p 8010 -p 45454 -p 2181 -p 50111 -p 9083 -p 10000 -p 9999 -p 9933 -p 22  -name hiveserver -h hiveserver -i -t $2 bash
