#!/bin/bash
source /root/scripts/usersAndGroups.sh
source /root/scripts/directories.sh

#groupadd $HADOOP_GROUP
#useradd $HDFS_USER -g $HADOOP_GROUP
#useradd $YARN_USER -g $HADOOP_GROUP
#useradd $MAPRED_USER -g $HADOOP_GROUP
useradd $PIG_USER -g $HADOOP_GROUP
#useradd $HIVE_USER -g $HADOOP_GROUP
#useradd $WEBHCAT_USER -g $HADOOP_GROUP
#useradd $HBASE_USER -g $HADOOP_GROUP
#useradd $ZOOKEEPER_USER -g $HADOOP_GROUP
#useradd $OOZIE_USER -g $HADOOP_GROUP
#useradd $TEZ_USER -g $HADOOP_GROUP

# Make root an HDFS superuser
usermod -a -G hdfs root
usermod -a -G hadoop root

usermod -a -G hdfs mapred


mkdir -p $DFS_NAME_DIR  && chown -R $HDFS_USER:$HADOOP_GROUP $DFS_NAME_DIR && chmod -R 755 $DFS_NAME_DIR 
mkdir -p $HADOOP_CONF_DIR  && chown -R $HDFS_USER:$HADOOP_GROUP $HADOOP_CONF_DIR && chmod -R 755 $HADOOP_CONF_DIR
mkdir -p $FS_CHECKPOINT_DIR && chown -R $HDFS_USER:$HADOOP_GROUP $FS_CHECKPOINT_DIR && chmod -R 755 $FS_CHECKPOINT_DIR 
 
# on datanode:
mkdir -p $DFS_DATA_DIR && chown -R $HDFS_USER:$HADOOP_GROUP $DFS_DATA_DIR && chmod -R 750 $DFS_DATA_DIR
mkdir -p $YARN_LOCAL_DIR && chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_DIR && chmod -R 755 $YARN_LOCAL_DIR
mkdir -p $YARN_LOCAL_LOG_DIR && chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOCAL_LOG_DIR && chmod -R 755 $YARN_LOCAL_LOG_DIR
 
#on all nodes:
mkdir -p $HDFS_LOG_DIR && chown -R $HDFS_USER:$HADOOP_GROUP $HDFS_LOG_DIR && chmod -R 755 $HDFS_LOG_DIR
mkdir -p /var/log/hadoop/hdfs/ && chown -R $HDFS_USER:$HADOOP_GROUP /var/log/hadoop/hdfs/ && chmod -R 755 /var/log/hadoop/hdfs/
mkdir -p $YARN_LOG_DIR && chown -R $YARN_USER:$HADOOP_GROUP $YARN_LOG_DIR && chmod -R 755 $YARN_LOG_DIR
mkdir -p $HDFS_PID_DIR && chown -R $HDFS_USER:$HADOOP_GROUP $HDFS_PID_DIR &&  chmod -R 755 $HDFS_PID_DIR
mkdir -p $YARN_PID_DIR && chown -R $YARN_USER:$HADOOP_GROUP $YARN_PID_DIR && chmod -R 755 $YARN_PID_DIR
mkdir -p $MAPRED_LOG_DIR && chown -R $MAPRED_USER:$HADOOP_GROUP $MAPRED_LOG_DIR && chmod -R 755 $MAPRED_LOG_DIR
mkdir -p $MAPRED_PID_DIR && chown -R $MAPRED_USER:$HADOOP_GROUP $MAPRED_PID_DIR && chmod -R 755 $MAPRED_PID_DIR

mkdir -p $ZOOKEEPER_LOG_DIR && chown -R $ZOOKEEPER_USER:$HADOOP_GROUP $ZOOKEEPER_LOG_DIR && chmod -R 755 $ZOOKEEPER_LOG_DIR;
mkdir -p $ZOOKEEPER_PID_DIR && chown -R $ZOOKEEPER_USER:$HADOOP_GROUP $ZOOKEEPER_PID_DIR && chmod -R 755 $ZOOKEEPER_PID_DIR;
mkdir -p $ZOOKEEPER_DATA_DIR && chmod -R 755 $ZOOKEEPER_DATA_DIR && chown -R $ZOOKEEPER_USER:$HADOOP_GROUP $ZOOKEEPER_DATA_DIR
mkdir -p $ZOOKEEPER_CONF_DIR && chmod -R 755 $ZOOKEEPER_CONF_DIR && chown -R $ZOOKEEPER_USER:$HADOOP_GROUP $ZOOKEEPER_CONF_DIR

mkdir -p $PIG_CONF_DIR && chown -R $PIG_USER:$HADOOP_GROUP $PIG_CONF_DIR && chmod -R 755 $PIG_CONF_DIR;
mkdir -p $PIG_LOG_DIR && chown -R $PIG_USER:$HADOOP_GROUP $PIG_LOG_DIR && chmod -R 755 $PIG_LOG_DIR;
mkdir -p $PIG_PID_DIR && chown -R $PIG_USER:$HADOOP_GROUP $PIG_PID_DIR && chmod -R 755 $PIG_PID_DIR;

mkdir -p $OOZIE_CONF_DIR && chown -R $OOZIE_USER:$HADOOP_GROUP $OOZIE_CONF_DIR && chmod -R 755 $OOZIE_CONF_DIR;
mkdir -p $OOZIE_DATA && chown -R $OOZIE_USER:$HADOOP_GROUP $OOZIE_DATA && chmod -R 755 $OOZIE_DATA;
mkdir -p $OOZIE_LOG_DIR && chown -R $OOZIE_USER:$HADOOP_GROUP $OOZIE_LOG_DIR && chmod -R 755 $OOZIE_LOG_DIR;
mkdir -p $OOZIE_PID_DIR && chown -R $OOZIE_USER:$HADOOP_GROUP $OOZIE_PID_DIR && chmod -R 755 $OOZIE_PID_DIR;
mkdir -p $OOZIE_TMP_DIR && chown -R $OOZIE_USER:$HADOOP_GROUP $OOZIE_TMP_DIR && chmod -R 755 $OOZIE_TMP_DIR;

mkdir -p $HIVE_CONF_DIR && chown -R $HIVE_USER:$HADOOP_GROUP $HIVE_CONF_DIR && chmod -R 755 $HIVE_CONF_DIR;
mkdir -p $HIVE_LOG_DIR && chown -R $HIVE_USER:$HADOOP_GROUP $HIVE_LOG_DIR && chmod -R 755 $HIVE_LOG_DIR;
mkdir -p $HIVE_PID_DIR && chown -R $HIVE_USER:$HADOOP_GROUP $HIVE_PID_DIR && chmod -R 755 $HIVE_PID_DIR;
sudo chown -R hive:hadoop /var/lib/hive/

mkdir -p $WEBHCAT_CONF_DIR && chown -R $WEBHCAT_USER:$HADOOP_GROUP $WEBHCAT_CONF_DIR && chmod -R 755 $WEBHCAT_CONF_DIR;
mkdir -p $WEBHCAT_LOG_DIR && chown -R $WEBHCAT_USER:$HADOOP_GROUP $WEBHCAT_LOG_DIR && chmod -R 755 $WEBHCAT_LOG_DIR;
mkdir -p $WEBHCAT_PID_DIR && chown -R $WEBHCAT_USER:$HADOOP_GROUP $WEBHCAT_PID_DIR && chmod -R 755 $WEBHCAT_PID_DIR;

mkdir -p $HBASE_CONF_DIR && chown -R $HBASE_USER:$HADOOP_GROUP $HBASE_CONF_DIR && chmod -R 755 $HBASE_CONF_DIR;
mkdir -p $HBASE_LOG_DIR && chown -R $HBASE_USER:$HADOOP_GROUP $HBASE_LOG_DIR && chmod -R 755 $HBASE_LOG_DIR;
mkdir -p $HBASE_PID_DIR && chown -R $HBASE_USER:$HADOOP_GROUP $HBASE_PID_DIR && chmod -R 755 $HBASE_PID_DIR;

mkdir -p $SQOOP_CONF_DIR && chown -R $HDFS_USER:$HADOOP_GROUP $SQOOP_CONF_DIR && chmod -R 755 $SQOOP_CONF_DIR

mkdir -p $TEZ_CONF_DIR && chown -R $TEZ_USER:$HADOOP_GROUP $TEZ_CONF_DIR && chmod -R 755 $TEZ_CONF_DIR

# Copy config files
cp /root/configuration_files/core_hadoop/* /etc/hadoop/conf/
cp /root/configuration_files/hbase/* /etc/hbase/conf/
cp /root/configuration_files/pig/* /etc/pig/conf/
cp /root/configuration_files/webhcat/* /etc/hcatalog/conf/webhcat/
cp /root/configuration_files/hive/* /etc/hive/conf/
cp /root/configuration_files/oozie/* /etc/oozie/conf/
cp /root/configuration_files/sqoop/* /etc/sqoop/conf/
cp /root/configuration_files/zookeeper/* /etc/zookeeper/conf/
cp /root/configuration_files/tez/* /etc/tez/conf
cp /root/configuration_files/stinger/hive-site.xml /opt/apache-hive*/conf

# Remove overlapping SLF4J logging providers
rm -f /usr/lib/hive/lib/slf4j-log4j12-1.7.5.jar
rm -f /usr/lib/zookeeper/lib/slf4j-log4j12-1.6.1.jar

