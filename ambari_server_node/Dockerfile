FROM hwxu/ambari_node

MAINTAINER Rich Raposa, rich@hortonworks.com

# Install and configure Ambari server and agent
RUN yum -y install ambari-server ambari-agent wireshark
RUN ambari-server setup -s

ADD scripts/ /root/scripts
ADD start-scripts/ /root/start-scripts 
ADD blueprints/ /root/blueprints
