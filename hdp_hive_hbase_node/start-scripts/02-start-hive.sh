#!/bin/bash

if [[ ("$NODE_TYPE" == "hive") ]]; then
        echo "Starting Hive and Oozie..."
        export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec

	cp /root/conf/hive/hive-site.xml /etc/hive/conf
        /etc/init.d/mysqld start

        echo "CREATE DATABASE hive; use hive; source /usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-0.13.0.mysql.sql;" | mysql -u root
        echo "CREATE USER 'hive'@'%' IDENTIFIED BY 'hive'" | mysql -u root
        echo "CREATE USER 'hive'@'hiveserver' IDENTIFIED BY 'hive'" | mysql -u root
        echo "grant all on hive.* to 'hive'@'%'" | mysql -u root
        echo "grant all on *.* to root@'%'" | mysql -u root

        # We need at least one DataNode up and running, so the following command should verify this is the case
        hdfs dfsadmin -safemode wait
        export hiveserver_ip=$(ip addr | grep inet | grep eth0 | awk -F" " '{print $2}' | sed -e 's/\/.*$//')
        sudo -E -u hdfs hadoop fs -put -f /usr/lib/tez/* /apps/tez
        sudo -E -u hdfs hadoop fs -put -f /usr/lib/hive/lib/hive-exec.jar /apps/hive/install/
        sudo -E -u hive hive --service metastore &
        sudo -E -u hive /usr/lib/hive/bin/hiveserver2 &
        # Start WebHCat server
        sudo -E -u hcat /etc/hcatalog/conf/webhcat/webhcat-env.sh && env HADOOP_HOME=/usr/lib/hadoop /usr/lib/hcatalog/sbin/webhcat_server.sh start     
        # Start oozie
        yum -y install extjs-2.2-1
        cp /usr/share/HDP-oozie/ext-2.2.zip /usr/lib/oozie/libext/
	cp /usr/lib/hadoop/lib/hadoop-lzo-*.jar /usr/lib/oozie/libext/
        sudo -E -u oozie /usr/lib/oozie/bin/oozie-setup.sh prepare-war
        sudo -E -u oozie /usr/lib/oozie/bin/ooziedb.sh create -run Validate DB Connection
        sudo -E -u oozie /usr/lib/oozie/bin/oozie-setup.sh sharelib create -fs hdfs://namenode:8020
        sudo -E -u oozie /usr/lib/oozie/bin/oozied.sh start
fi
