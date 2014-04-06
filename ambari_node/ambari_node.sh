#!/bin/bash

if [ $# -lt 1 ]
  then
    echo "Usage: ambari_node.sh  <node_name>"
    exit
fi
docker run -dns 127.0.0.1 -h $1 -name $1 -p 22 -link node1:node1 -p 8440 -p 8441 -i -t hwx/ambari_node
