#
#
#
FROM hwxu/hdp_node
MAINTAINER Rich Raposa, rich@hortonworks.com

RUN yum -y install mysql-server
RUN chkconfig mysqld on
RUN yum -y install mysql-connector-java*
RUN cp /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib

# Copy over custom scripts and config files
ADD start-scripts/ /root/start-scripts/
ADD conf /root/conf
