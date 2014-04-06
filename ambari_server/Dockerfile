#
#
#	1. Install basic rpm's not included in the centos base
#	2. Install JDK
#	3. Create the users, install folders, and configure appropriate file permissions
#	
#
#
FROM hwx/ambari_server_base

MAINTAINER Rich Raposa, rich@hortonworks.com

ADD scripts/ /root/scripts/
ADD conf/90-nproc.conf /etc/security/limits.d/
ADD conf/system-auth /etc/pam.d/

ENTRYPOINT ["/root/scripts/startup.sh"]
