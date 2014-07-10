#
#
#
FROM hwxu/hdp_node
MAINTAINER Rich Raposa, rich@hortonworks.com

# Copy over custom scripts and config files
ADD conf/ /root/conf/
ADD start-scripts/ /root/start-scripts/

RUN cp /root/conf/zookeeper/* /etc/zookeeper/conf

# Rename conflicing SLF4J jar file
RUN mv /usr/lib/zookeeper/lib/slf4j-log4j12-1.6.1.jar /usr/lib/zookeeper/lib/slf4j-log4j12-1.6.1.jar.old

