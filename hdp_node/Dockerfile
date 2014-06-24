#
#
#
FROM hwxu/hdp_node_base
MAINTAINER Rich Raposa, rich@hortonworks.com

# Install nano and vim text editors
RUN yum -y install nano vim

# sudo is needed to run the Hadoop binaries
RUN yum -y install sudo bind-utils zip

# Copy over custom scripts and config files
ADD scripts/ /root/scripts/
ADD start-scripts/ /root/start-scripts/
ADD scripts/usersAndGroups.sh /etc/profile.d/
ADD scripts/directories.sh /etc/profile.d/
ADD scripts/hdp_env.sh /etc/profile.d/
RUN rm -rf /etc/profile.d/colorls.csh 

# Copy the HDP config files to their appropriate folders
RUN mkdir /root/configuration_files/
ADD configuration_files/ /root/configuration_files/

# The hdfs user needs to put hive-exec.jar into HDFS for Tez
RUN chown hdfs:hdfs /usr/lib/hive/lib/hive-exec.jar

RUN echo "source /etc/bashrc" >> /root/.bash_profile

EXPOSE 8010 8020 9000 50070 8088 8032 50060 9000 50075 50010 50020 50060 50090 10000 9999 9933 8081 8030 8050 8025 8141 19888 45454 10020 2181 50111 9083 11000 8080 3372 3373 6627 6700 6701 6702 6703 9080 9081 9082 9083 9084 9085 9086 9087

ENTRYPOINT ["/root/scripts/startup.sh"]
