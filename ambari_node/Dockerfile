#
#
#	1. Install basic rpm's not included in the centos base
#	2. Install JDK
#	3. Create the users, install folders, and configure appropriate file permissions
#	
#
#
FROM hwx/ambari_node_base

MAINTAINER Rich Raposa, rich@hortonworks.com

ADD scripts/ /root/scripts/
ADD repos/ /etc/yum.repos.d/
ADD conf/90-nproc.conf /etc/security/limits.d/
ADD conf/system-auth /etc/pam.d/

EXPOSE 8440 8441 

ENTRYPOINT ["/root/scripts/startup.sh"]
