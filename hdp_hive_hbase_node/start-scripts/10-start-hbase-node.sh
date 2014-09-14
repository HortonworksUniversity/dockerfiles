#!/bin/bash

if [ "$NODE_TYPE" == "namenode" ] ; then
  su -l hdfs -c "hdfs dfsadmin -safemode wait" 
  su -l hdfs -c "hadoop fs -mkdir /apps/hbase"
  su -l hdfs -c "hadoop fs -chown hbase:hadoop /apps/hbase"
  cat /root/conf/supervisor/hmaster-supervisord.conf >> /etc/supervisord.conf
elif [[ ("$NODE_TYPE" == "workernode") ]]; then
  su -l hdfs -c "hdfs dfsadmin -safemode wait"
  cat /root/conf/supervisor/hregionserver-supervisord.conf >> /etc/supervisord.conf
fi
