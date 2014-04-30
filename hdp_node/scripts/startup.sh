#!/bin/bash

chkconfig sshd on 
chkconfig ntpd on

/etc/init.d/sshd start
/etc/init.d/ntpd start

source /root/scripts/usersAndGroups.sh
source /root/scripts/directories.sh
/root/scripts/createUsersAndDirectories.sh

umount /etc/hosts
cp /root/conf/hosts /etc/

# The following link is used by all the Hadoop scripts
rm /usr/java/default
mkdir /usr/java/default
mkdir /usr/java/default/bin/
ln -s /usr/bin/java /usr/java/default/bin/java

# Fix a bug in HDP 2
chown root:hadoop /usr/lib/hadoop-yarn/bin/container-executor
chmod 6050 /usr/lib/hadoop-yarn/bin/container-executor 

if [ "$NODE_TYPE" == "namenode" ] ; then
        echo "Starting NameNode..."
        sudo -E -u hdfs /usr/lib/hadoop/bin/hadoop namenode -format -nonInteractive
        sudo -E -u hdfs /usr/lib/hadoop/sbin/hadoop-daemon.sh start namenode
	/root/scripts/createHDFSdirectories.sh
	bash
elif [ "$NODE_TYPE" == "secondarynamenode" ] ; then
        echo "Starting SecondaryNameNode..."
	sudo -E -u hdfs /usr/lib/hadoop/sbin/hadoop-daemon.sh start secondarynamenode
	bash
elif [ "$NODE_TYPE" == "resourcemanager" ] ; then
        echo "Starting ResourceManager..."

	# Start the resourcemanager and historyserver
	export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec
	sudo -E -u yarn /usr/lib/hadoop-yarn/sbin/yarn-daemon.sh --config /etc/hadoop/conf start resourcemanager
	sudo -E -u mapred /usr/lib/hadoop-mapreduce/sbin/mr-jobhistory-daemon.sh --config /etc/hadoop/conf start historyserver
	bash
elif [[ ("$NODE_TYPE" == "hiveserver") || ("$NODE_TYPE" == "hiveserver-tez") ]] ; then
        echo "Starting Hive and Oozie..."
	/usr/lib/zookeeper/bin/zkServer.sh start
        export hiveserver_ip=$(ip addr | grep inet | grep eth0 | awk -F" " '{print $2}' | sed -e 's/\/.*$//')
        if [ "$NODE_TYPE" == "hiveserver-tez" ] ; then
                source /root/configuration_files/stinger/stinger-env.sh
		cat /root/configuration_files/stinger/stinger-env.sh >> /etc/bashrc
		sudo -u hdfs hadoop fs -put -f /opt/apache-hive-0.13*-bin/lib/hive-exec-*.jar /user/hive/hive-exec-0.13.0-SNAPSHOT.jar
		sudo -E -u hdfs hadoop fs -put -f /opt/tez-0.2.0.2.1.0.0-92/* /apps/tez
        fi
	# Start Metastore and Hiveserver2
        if [ "$NODE_TYPE" == "hiveserver-tez" ] ; then
          sudo -E -u hive /opt/apache-hive-0.13*-bin/bin/hive --service metastore &
	  sudo -E -u hive /opt/apache-hive-0.13*-bin/bin/hiveserver2 &
        else
          sudo -E -u hive hive --service metastore &
  	  sudo -E -u hive /usr/lib/hive/bin/hiveserver2 &
        fi
	# Start WebHCat server
	sudo -E -u hcat /etc/hcatalog/conf/webhcat/webhcat-env.sh && env HADOOP_HOME=/usr/lib/hadoop /usr/lib/hcatalog/sbin/webhcat_server.sh start	
	# Start oozie
	sudo -E -u oozie /etc/oozie/conf/oozie-env.sh && /usr/lib/oozie/bin/oozie-setup.sh prepare-war
	sudo -E -u oozie /etc/oozie/conf/oozie-env.sh &&  /usr/lib/oozie/bin/ooziedb.sh create -sqlfile oozie.sql -run Validate DB Connection
	sudo -E -u oozie /etc/oozie/conf/oozie-env.sh && /usr/lib/oozie/bin/oozied.sh start
	bash
elif [ "$NODE_TYPE" == "workernode" ] ; then
        echo "Starting Worker Node..."
	# Start datanode and nodemanagaer daemons 
	sudo -E -u hdfs /usr/lib/hadoop/sbin/hadoop-daemon.sh start datanode
        export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec
	sudo -E -u yarn /usr/lib/hadoop-yarn/sbin/yarn-daemon.sh --config /etc/hadoop/conf start nodemanager
	bash
else
        bash
fi
