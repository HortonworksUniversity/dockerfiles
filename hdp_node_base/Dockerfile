#
#
#	1. Install basic rpm's not included in the centos base
#	2. Install JDK
#	3. Create the users, install folders, and configure appropriate file permissions
#	
#
#
FROM centos:6.4

MAINTAINER Rich Raposa, rich@hortonworks.com


# HDP Software Requirements that are not a part of centos base
RUN yum -y install openssh-server  openssh-clients unzip ntp wget yum-priorities

# Install OpenJDK 7
RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel \
	&&  mkdir /usr/java \
	&& ln -s /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64  /usr/java/default
ENV JAVA_HOME /usr/java/default

# Configure the HDP Repository
# RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos6/2.x/GA/2.1.1.0/hdp.repo -O /etc/yum.repos.d/hdp.repo
RUN wget -nv http://public-repo-1.hortonworks.com/HDP/centos6/2.x/GA/2.1-latest/hdp.repo -O /etc/yum.repos.d/hdp.repo 

# Install compression libraries
RUN yum -y install snappy snappy-devel
RUN yum -y install lzo lzo-devel hadoop-lzo hadoop-lzo-native

# Install HDP
RUN yum -y install --nogpgcheck hadoop hadoop-hdfs hadoop-libhdfs hadoop-yarn hadoop-mapreduce hadoop-client openssl
RUN yum -y install --nogpgcheck pig hive hive-hcatalog webhcat-tar-hive webhcat-tar-pig oozie oozie-client tez mahout storm falcon knox hue

# Install HBase
RUN yum -y install --nogpgcheck zookeeper hbase phoenix

# Install Sqoop
RUN yum -y install sqoop

# Install Ganglia client 
RUN yum -y install --nogpgcheck ganglia-gmond-3.5.0-99 

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

EXPOSE 22

