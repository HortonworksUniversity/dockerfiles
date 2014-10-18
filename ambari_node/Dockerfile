FROM centos:centos6

MAINTAINER Rich Raposa, rich@hortonworks.com

# HDP Software Requirements that are not a part of centos base
RUN yum -y install openssh-server openssh-clients unzip ntp wget yum-priorities tar

# Install nano and vim text editors
RUN yum -y install nano vim

# sudo is needed to run the Hadoop binaries
RUN yum -y install sudo bind-utils zip

# Configure the Ambari Repository
RUN wget http://s3.amazonaws.com/dev.hortonworks.com/ambari/centos6/1.x/updates/1.7.0/ambari.repo -O /etc/yum.repos.d/ambari.repo

RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_dsa_key

#Set up passwordless ssh
RUN mkdir /root/.ssh
ADD conf/id_rsa /root/.ssh/id_rsa
ADD conf/id_rsa.pub /root/.ssh/id_rsa.pub
ADD conf/sshd_config /etc/ssh/
RUN touch /root/.ssh/authorized_keys \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod -R 600 /root/.ssh/
RUN echo "IdentityFile /root/.ssh/id_rsa" >> /etc/ssh/ssh_config

# Copy scripts and config files onto new container
RUN mkdir /root/scripts && mkdir /root/conf && mkdir /root/start-scripts
ADD conf/ /root/conf/
ADD conf/config /etc/selinux/config
ADD scripts/ /root/scripts/
ADD start-scripts/ /root/start-scripts/

RUN echo "source /etc/bashrc" >> /root/.bash_profile

RUN echo "root:hadoop" | chpasswd

# Add Java to the path
RUN echo "export JAVA_HOME=/usr/jdk64/jdk1.7.0_67/" >> /etc/bashrc
RUN echo "export PATH=/usr/jdk64/jdk1.7.0_67/bin:\$PATH" >> /etc/bashrc

EXPOSE 22 8010 8020 9000 50070 8088 8032 50060 9000 50075 50010 50020 50060 50090 10000 9999 9933 8081 8030 8050 8025 8141 19888 45454 10020 2181 50111 9083 11000 8080 3372 3373 6627 6700 6701 6702 6703 9080 9081 9082 9083 9084 9085 9086 9087

ENTRYPOINT ["/root/scripts/startup.sh"]

