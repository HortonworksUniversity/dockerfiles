#!/bin/bash

if [ $# -lt 1 ]
  then
    echo "Usage: ambari_cluster.sh <num_of_workernodes_in_cluster>"
    exit
fi

#Start the NameNode
echo "Starting NameNode..."
CID_namenode=$(docker run -d --dns 127.0.0.1 -p 8080:8080 -p 8440:8440 -p 8441:8441 -p 50070:50070 -p 8020:8020 -e NODE_TYPE=namenode --name namenode -h namenode -i -t hwx/ambari_server)
IP_namenode=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" namenode)
echo "NameNode started at $IP_namenode"

#Start the ResourceManager
echo "Starting ResourceManager..."
CID_resourcemanager=$(docker run -d --link namenode:namenode -e namenode_ip=$IP_namenode -e NODE_TYPE=resourcemanager --dns 127.0.0.1 -p 8088:8088 -p 8032:8032 -p 50060:50060 -p 8081:8081 -p 8030:8030 -p 8050:8050 -p 8025:8025 -p 8141 -p 19888:19888 -p 45454 -p 10020:10020 -p 22 --name resourcemanager -h resourcemanager -i -t hwx/ambari_node)
IP_resourcemanager=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" resourcemanager)
echo "ResourceManager running on $IP_resourcemanager"

#Start the SecondaryNameNode
echo "Starting SecondaryNameNode..."
CID_snn=$(docker run -d --link namenode:namenode -e namenode_ip=$IP_namenode --dns 127.0.0.1 -p 50090:50090 -p 22  -e NODE_TYPE=secondarynamenode --name secondarynamenode -h secondarynamenode -i -t hwx/ambari_node)
IP_snn=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" secondarynamenode)
echo "SecondaryNameNode running $IP_ssn"

#Start the Hive/Oozie Server
echo "Starting a Hive/Oozie server..."
CID_hive=$(docker run -d --link namenode:namenode -e namenode_ip=$IP_namenode -e NODE_TYPE=hiveserver --dns 127.0.0.1 -p 11000:11000 -p 2181 -p 50111:50111 -p 9083 -p 10000 -p 9999:9999 -p 9933:9933 -p 22  --name toolserver -h toolserver -i -t hwx/ambari_node bash)
IP_hive=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" toolserver)
echo "Hive/Oozie running on $IP_hive"

#Start the worker node 
echo "Starting $1 nodes..."
for (( i=1; i<=$1; ++i));
do
nodename="node$i"
CID=$(docker run -d --dns 127.0.0.1 -h $nodename --name $nodename -p 22 --link namenode:namenode -p 8440 -p 8441 -i -t hwx/ambari_node)
IP_node=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" $nodename)
echo "Started $nodename on IP $IP_node"
done

echo "Cluster is ready to be installed at http://namenode:8080/" 
