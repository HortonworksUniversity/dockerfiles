#!/bin/bash

java -jar /root/scripts/ambari-shell.jar --ambari.host=namenode << END &
blueprint add --file /root/blueprints/singlenode.blueprint
cluster build --blueprint singlenode
cluster assign --hostGroup master --host namenode
cluster create --exitOnFinish true
quit
END

sleep 20
kill -9 %1
reset
clear
echo "HDP is currently installing. Run install_status.sh to check progress"
