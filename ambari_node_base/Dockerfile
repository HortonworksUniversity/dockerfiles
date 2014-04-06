#
#
#	1. Install basic rpm's not included in the centos base
#	2. Install JDK
#	3. Create the users, install folders, and configure appropriate file permissions
#	
#
#
FROM centos

MAINTAINER Rich Raposa, rich@hortonworks.com

# HDP Software Requirements that are not a part of centos base
ADD conf/yum.conf /etc/yum.conf
RUN yum -y install openssh-server  openssh-clients unzip ntp wget yum-priorities httpd

# Install OpenJDK 7
#RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel \
#	&&  mkdir /usr/java \
#	&& ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64  /usr/java/default

#Install Oracle JDK
RUN wget --no-cookies  "http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-6u31-linux-x64.bin" -O /tmp/jdk-6u31-linux-x64.bin --no-check-certificate
RUN chmod +x /tmp/jdk-6u31-linux-x64.bin
RUN /tmp/jdk-6u31-linux-x64.bin

#ENV JAVA_HOME /usr/java/default
ENV JAVA_HOME /jdk1.6.0_31


RUN yum -y install yum-utils createrepo


RUN yum -y install yum-priorities 
RUN echo "[main]" > /etc/yum/pluginconf.d/priorities.conf
RUN echo "enabled=1" >> /etc/yum/pluginconf.d/priorities.conf
RUN echo "gpgcheck=0" >> /etc/yum/pluginconf.d/priorities.conf


# Configure passwordless SSH amongst the nodes
RUN touch /etc/sysconfig/network 

RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_dsa_key

RUN mkdir /root/.ssh
ADD conf/id_rsa /root/.ssh/id_rsa
ADD conf/id_rsa.pub /root/.ssh/id_rsa.pub
ADD conf/sshd_config /etc/ssh/
RUN touch /root/.ssh/authorized_keys \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod -R 600 /root/.ssh/
RUN echo "IdentityFile /root/.ssh/id_rsa" >> /etc/ssh/ssh_config

# Copy scripts and config files onto new container
RUN mkdir /root/scripts && mkdir /root/conf
ADD conf/ /root/conf/
ADD conf/config /etc/selinux/config
RUN echo "root:hadoop" | chpasswd

# sudo is needed to run the Hadoop binaries
RUN yum -y install sudo bind-utils

ADD conf/hosts /etc/
# Installing dnsmasq because /etc/hosts is read-only
RUN yum -y install dnsmasq
RUN echo 'listen-address=127.0.0.1' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf
RUN echo 'addn-hosts=/etc/banner_add_hosts' >> /etc/dnsmasq.conf
# RUN touch /etc/banner_add_hosts
RUN cp /root/conf/0hosts /etc/dnsmasq.d/
RUN cp /root/conf/banner_add_hosts /etc/
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf
# Fix a bug in dnsmasq
#RUN sed -i '17d' /etc/init.d/dnsmasq

EXPOSE 22

EXPOSE 8010 8020 9000 50070 8088 8032 50060 9000 50075 50010 50020 50090 10000 9999 9933 8081 8030 8050 8025 8141 19888 45454 10020 2181 50111 9083 11000

