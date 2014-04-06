#!/bin/bash

#Start node1, which will be running the ambari-server process
echo "Starting node1..."
CID_namenode=$(docker run -d --privileged=true --dns 127.0.0.1 -p 8080:8080 -p 8440:8440 -p 8441:8441 -p 50070:50070 -p 8020:8020 -e NODE_TYPE=namenode --name node1 -h node1 -i -t hwx/ambari_server)
IP_namenode=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" node1)
echo "node1 started at $IP_namenode"

for (( i=2; i<=4; ++i));
do
nodename="node$i"
CID=$(docker run -d --dns 127.0.0.1 --privileged=true -h $nodename --name $nodename -p 22 --link node1:node1 -p 8440 -p 8441 -i -t hwx/ambari_node)
IP_node=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" $nodename)
echo "Started $nodename on IP $IP_node"
done

echo "Cluster is ready to be installed at http://node1:8080/" 
