FROM hwxu/ambari_node

MAINTAINER Rich Raposa, rich@hortonworks.com

# Install and configure Ambari agent
RUN yum -y install ambari-agent

RUN sed -i '/^hostname=.*$/c\hostname=namenode' /etc/ambari-agent/conf/ambari-agent.ini

ADD start-scripts/ /root/start-scripts

