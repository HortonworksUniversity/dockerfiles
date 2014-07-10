#!/bin/bash

if [ "$NODE_TYPE" == "namenode" ] ; then
  su -l hdfs -c "hdfs dfsadmin -safemode wait" 
  su -l hdfs -c "hadoop fs -mkdir /apps/hbase"
  su -l hdfs -c "hadoop fs -chown hbase:hadoop /apps/hbase"
  su -l hbase -c "/usr/lib/hbase/bin/hbase-daemon.sh start master"
elif [[ ("$NODE_TYPE" == "workernode") ]]; then
  su -l hdfs -c "hdfs dfsadmin -safemode wait"
  su -l hbase -c "/usr/lib/hbase/bin/hbase-daemon.sh start regionserver"
fi

