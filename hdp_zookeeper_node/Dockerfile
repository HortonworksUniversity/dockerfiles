#
#
#
FROM hwxu/hdp_node
MAINTAINER Rich Raposa, rich@hortonworks.com

# Install supervisor daemon
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
RUN rm -f remi-release-6*.rpm epel-release-6*.rpm
RUN yum -y install supervisor

# Copy over custom scripts and config files
ADD conf/ /root/conf/
ADD start-scripts/ /root/start-scripts/

RUN cp /root/conf/zookeeper/* /etc/zookeeper/conf

# Rename conflicing SLF4J jar file
RUN mkdir -p /usr/lib/zookeeper/build/lib
RUN mv /usr/lib/zookeeper/lib/slf4j-log4j12-1.6.1.jar /usr/lib/zookeeper/build/lib
