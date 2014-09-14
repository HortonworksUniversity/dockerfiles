#!/bin/bash

if [ "$NODE_TYPE" == "namenode" ] ; then
        #Start zookeeper
        su -l zookeeper -c "echo 1 > /hadoop/zookeeper/data/myid"
        cat /root/conf/supervisor/zookeeper-supervisord.conf >> /etc/supervisord.conf
elif [ "$NODE_TYPE" == "resourcemanager" ] ; then
	# Start zookeeper
        su -l zookeeper -c "echo 2 > /hadoop/zookeeper/data/myid"
        cat /root/conf/supervisor/zookeeper-supervisord.conf >> /etc/supervisord.conf
elif [[ ("$NODE_TYPE" == "hiveserver") || ("$NODE_TYPE" == "hive") ]]; then
	# Start zookeeper
        su -l zookeeper -c "echo 3 > /hadoop/zookeeper/data/myid"
        cat /root/conf/supervisor/zookeeper-supervisord.conf >> /etc/supervisord.conf
fi

chkconfig supervisord on
/etc/init.d/supervisord restart
