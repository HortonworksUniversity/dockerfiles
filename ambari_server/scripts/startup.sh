#!/bin/bash

chkconfig sshd on 
chkconfig ntpd on

/etc/init.d/sshd start
#/etc/init.d/ntpd start
ntpd

# start DNS
service dnsmasq restart

grep -v rootfs /proc/mounts > /etc/mtab
umask 022

service httpd start
ambari-server start

bash
