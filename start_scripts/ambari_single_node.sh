#!/bin/bash

#Start the Ambari Server 
echo "Starting Namenode/Ambari Server..."
CID_namenode=$(docker run --privileged=true -d --dns 8.8.8.8 -p 8080:8080 -p 8440:8440 -p 8441:8441 -p 50070:50070 -p 8020:8020 -e AMBARI_SERVER=namenode -e NAGIOS_EMAIL=$1 -e NODE_TYPE=namenode --name namenode -h namenode -i -t hwxu/ambari_server_node)
IP_namenode=$(docker inspect --format "{{ .NetworkSettings.IPAddress }}" namenode)
echo "Namenode/Ambari Server started at $IP_namenode"

