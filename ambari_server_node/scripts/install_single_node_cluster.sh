#!/bin/bash

BLUEPRINT_FILE=$1

: ${BLUEPRINT_FILE:="singlenode.blueprint"}
BLUEPRINT_NAME="${BLUEPRINT_FILE%.*}"

java -jar /root/scripts/ambari-shell.jar --ambari.host=namenode << END &
blueprint add --file /root/blueprints/$BLUEPRINT_FILE
cluster build --blueprint $BLUEPRINT_NAME  
cluster assign --hostGroup master --host namenode
cluster create --exitOnFinish true
quit
END

sleep 20
kill -9 %1
reset
clear
echo "HDP is currently installing. Run install_status.sh to check progress"
