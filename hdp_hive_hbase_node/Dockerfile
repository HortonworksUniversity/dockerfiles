#
#
#
FROM hwxu/hdp_zookeeper_node
MAINTAINER Rich Raposa, rich@hortonworks.com

RUN yum -y install mysql-server
RUN chkconfig mysqld on
RUN yum -y install mysql-connector-java*
RUN cp /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib

# Copy over custom scripts and config files
ADD start-scripts/ /root/start-scripts/
ADD conf /root/conf

RUN cp /root/conf/hbase/* /etc/hbase/conf

#Add Phoenix jar file to HBase
RUN ln -sf `ls /usr/lib/phoenix/lib/phoenix-core*jar | grep -vi sources | grep -vi tests` /usr/lib/hbase/lib/phoenix.jar

#Add HBase config to Phoenix
RUN cp /etc/hbase/conf/hbase-site.xml /usr/lib/phoenix/bin

#Update Phoenix log4j configuration to hide warnings
RUN cp /root/conf/phoenix/log4j.properties /usr/lib/phoenix/bin

#Deploy custom script to run SQLLine for Phoenix
RUN ln -sf /root/conf/phoenix/sqlline-phoenix /usr/bin

