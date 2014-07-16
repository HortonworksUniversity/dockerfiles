#!/bin/bash

java -jar /root/scripts/ambari-shell.jar --ambari.host=namenode << END &
blueprint add --file /root/blueprints/multinode.blueprint
cluster build --blueprint multinode
cluster assign --hostGroup namenode --host namenode
cluster assign --hostGroup resourcemanager --host resourcemanager 
cluster assign --hostGroup hiveserver --host hiveserver 
cluster assign --hostGroup worker --host node1 
cluster assign --hostGroup worker --host node2 
cluster assign --hostGroup worker --host node3 
cluster assign --hostGroup worker --host node4 
cluster create --exitOnFinish true
quit
END

sleep 20
kill -9 %1
reset
clear
echo "HDP is currently installing. Run install_status.sh to check progress"
