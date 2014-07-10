#!/bin/bash

yum install -y mysql 
echo "alias mysql='mysql -h hiveserver'" >> /etc/bashrc

if [ "$NODE_TYPE" == "namenode" ] ; then
  su -l hdfs -c "hdfs dfsadmin -safemode wait" 
  su -l hdfs -c "hadoop fs -mkdir /apps/hbase"
  su -l hdfs -c "hadoop fs -chown hbase:hadoop /apps/hbase"
  su -l hbase -c "/usr/lib/hbase/bin/hbase-daemon.sh start master"
elif [ "$NODE_TYPE" == "hiveserver" ] ; then
  yum install -y mysql-server
  chkconfig mysqld on
  /etc/init.d/mysqld start
  echo "grant all on *.* to root@node1" | mysql -u root
  echo "grant all on *.* to root@node2" | mysql -u root
  echo "grant all on *.* to root@node3" | mysql -u root
  echo "grant all on *.* to root@node4" | mysql -u root
  echo "grant all on *.* to root@namenode" | mysql -u root
  echo "grant all on *.* to root@resourcemanager" | mysql -u root
elif [[ ("$NODE_TYPE" == "workernode") ]]; then
  su -l hdfs -c "hdfs dfsadmin -safemode wait"
  su -l hbase -c "/usr/lib/hbase/bin/hbase-daemon.sh start regionserver"
fi

