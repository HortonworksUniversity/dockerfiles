#
#
#
FROM hwx/hdp_node_base
MAINTAINER Rich Raposa, rich@hortonworks.com

# sudo is needed to run the Hadoop binaries
RUN yum -y install sudo bind-utils

# Installing dnsmasq because /etc/hosts is read-only
RUN yum -y install dnsmasq
RUN echo 'listen-address=127.0.0.1' >> /etc/dnsmasq.conf
RUN echo 'resolv-file=/etc/resolv.dnsmasq.conf' >> /etc/dnsmasq.conf
RUN echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf
RUN echo 'addn-hosts=/etc/banner_add_hosts' >> /etc/dnsmasq.conf
RUN touch /etc/banner_add_hosts
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.dnsmasq.conf
RUN echo 'nameserver 8.8.4.4' >> /etc/resolv.dnsmasq.conf
# Fix a bug in dnsmasq
RUN sed -i '17d' /etc/init.d/dnsmasq

# Copy over custom scripts and config files
ADD scripts/ /root/scripts/
ADD scripts/usersAndGroups.sh /etc/profile.d/
ADD scripts/directories.sh /etc/profile.d/
ADD scripts/hdp_env.sh /etc/profile.d/
RUN rm -rf /etc/profile.d/colorls.csh 

# Copy the HDP config files to their appropriate folders
RUN mkdir /root/configuration_files/
ADD configuration_files/ /root/configuration_files/
ADD conf/ /root/conf/

EXPOSE 8010 8020 9000 50070 8088 8032 50060 9000 50075 50010 50020 50090 10000 9999 9933 8081 8030 8050 8025 8141 19888 45454 10020 2181 50111 9083 11000 

ENTRYPOINT ["/root/scripts/startup.sh"]
