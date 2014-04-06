#!/bin/bash

#if [ $# -lt 1 ]
#  then
#    echo "Usage: ambari_server.sh  <docker_image_name>"
#    exit
#fi
docker run -dns 127.0.0.1 -h node1 -name node1 -p 8080:8080 -p 8440:8440 -p 8441:8441 -i -t hwx/ambari_server 
