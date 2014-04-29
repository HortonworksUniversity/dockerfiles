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
RUN yum -y install openssh-server  openssh-clients unzip ntp wget yum-priorities

# Install OpenJDK 7
RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel \
	&&  mkdir /usr/java \
	&& ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64  /usr/java/default
ENV JAVA_HOME /usr/java/default

# Configure the HDP Repository
RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos6/2.x/updates/2.0.6.1/hdp.repo -O /etc/yum.repos.d/hdp.repo

# Install compression libraries
RUN yum -y install snappy snappy-devel
RUN yum -y install lzo lzo-devel hadoop-lzo hadoop-lzo-native

# Install HDP
RUN yum -y install --nogpgcheck hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client openssl
RUN yum -y install --nogpgcheck pig hive hcatalog webhcat-tar-hive webhcat-tar-pig oozie oozie-client

# Install HBase
RUN yum -y install --nogpgcheck zookeeper hbase

# Install Sqoop
RUN yum -y install sqoop

# Install Ganglia client 
# RUN yum -y install --nogpgcheck ganglia-gmond-3.5.0-99 

# Install Tez bits
RUN wget -nv http://public-repo-1.hortonworks.com/HDP-2.1.0.0/repos/centos6/tars/tez-0.2.0.2.1.0.0-92.tar.gz
RUN tar -C /opt -xzf tez-0.2.0.2.1.0.0-92.tar.gz
RUN wget -nv http://public-repo-1.hortonworks.com/HDP-2.1.0.0/repos/centos6/tars/apache-hive-0.13.0.2.1.0.0-92-bin.tar.gz
RUN tar -C /opt -xzf apache-hive-0.13.0.2.1.0.0-92-bin.tar.gz
RUN wget -nv http://public-repo-1.hortonworks.com/HDP-2.1.0.0/repos/centos6/hdp.repo -O /etc/yum.repos.d/stinger.repo
RUN yum upgrade hadoop-yarn-resourcemanager

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
ADD conf/hosts /etc/
RUN echo "root:hadoop" | chpasswd

EXPOSE 22

