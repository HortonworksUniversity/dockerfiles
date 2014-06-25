#!/bin/bash

if [[ ("$NODE_TYPE" == "hiveserver") ]]; then
	echo "Installing Tez JAR files.."
	sudo -E -u hdfs hadoop fs -put -f /usr/lib/tez/* /apps/tez
 	sudo -E -u hdfs hadoop fs -put -f /usr/lib/hive/lib/hive-exec.jar /apps/hive/install/
fi
