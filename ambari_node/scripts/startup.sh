#!/bin/bash

chkconfig sshd on 
chkconfig ntpd on

/etc/init.d/sshd start
#/etc/init.d/ntpd start
ntpd

setenforce 0
chkconfig iptables off
/etc/init.d/iptables stop

# Setup the hosts file and start DNS
#cp /root/conf/0hosts /etc/dnsmasq.d/0hosts
#cp /root/conf/banner_add_hosts /etc/banner_add_hosts
service dnsmasq restart

export datanode_ip=$(ip addr | grep inet | grep eth0 | awk -F" " '{print $2}' | sed -e 's/\/.*$//')

#ssh -o StrictHostKeyChecking=no root@$namenode_ip "/root/scripts/add_host.sh $datanode_ip $(hostname)"
#ssh -o StrictHostKeyChecking=no root@$namenode_ip "/root/scripts/copy_dns.sh"


grep -v rootfs /proc/mounts > /etc/mtab
umask 022

bash
