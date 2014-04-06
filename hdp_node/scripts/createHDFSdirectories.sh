#!/bin/bash

sudo -u hdfs pig <<DONE

fs -mkdir /mapred;
fs -chown mapred:hdfs /mapred;

-- JobHistory Server folders
fs -mkdir -p /mr-history/tmp;
fs -chmod -R 1777 /mr-history/tmp;
fs -mkdir -p /mr-history/done;
fs -chmod -R 1777 /mr-history/done;
fs -chown -R mapred:hdfs /mr-history;
fs -mkdir -p /app-logs;
fs -chmod -R 1777 /app-logs;
fs -chown yarn /app-logs;

-- Create home directory for users
fs -mkdir -p /user/root;
fs -chown -R root:root /user/root;
fs -mkdir -p /user/hdfs;
fs -chown -R hdfs:hdfs /user/hdfs;

-- Create Hive folders in HDFS
fs -mkdir -p /apps/hive/warehouse;
fs -chown -R hive:hdfs /apps/hive;
fs -chmod -R 775 /apps/hive;
fs -mkdir -p /tmp/scratch;
fs -chown -R hdfs:hdfs /tmp;
fs -chmod -R 777 /tmp;
fs -mkdir -p /user/hive;
fs -chown -R hive:hdfs /user/hive;

-- Create WebHCat folders
fs -mkdir -p /user/hcat;
fs -chown -R hcat:hdfs /user/hcat;
fs -mkdir /apps/webhcat;
fs -chown -R hcat:users /apps/webhcat;
fs -chmod -R 755 /apps/webhcat;

-- Create Tez folders
fs -mkdir -p /apps/tez
fs -chmod 755 /apps/tez

DONE
