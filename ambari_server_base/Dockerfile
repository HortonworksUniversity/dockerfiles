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

RUN yum -y install yum-utils createrepo

RUN mkdir -p /var/www/html/hdp
RUN mkdir /var/www/html/hdp/HDP-2.x
RUN mkdir /var/www/html/hdp/HDP-UTILS-1.1.0.16
RUN mkdir /var/www/html/hdp/Updates-HDP-2.x
RUN mkdir /var/www/html/hdp/Updates-ambari-1.4.4.23


ADD repos/ /etc/yum.repos.d/
ADD conf/yum.conf /etc/yum.conf

RUN reposync -r HDP-2.x -p /var/www/html/hdp/
RUN reposync -r HDP-UTILS-1.1.0.16  -p /var/www/html/hdp/
RUN reposync -r Updates-HDP-2.x -p /var/www/html/hdp/
RUN reposync -r ambari-1.x -p /var/www/html/hdp/
RUN reposync -r Updates-ambari-1.4.4.23 -p /var/www/html/hdp/


RUN createrepo /var/www/html/hdp/HDP-2.x
RUN createrepo /var/www/html/hdp/Updates-HDP-2.x
RUN createrepo /var/www/html/hdp/HDP-UTILS-1.1.0.16
RUN createrepo /var/www/html/hdp/ambari-1.x
RUN createrepo /var/www/html/hdp/Updates-ambari-1.4.4.23


RUN yum -y install ambari-server
RUN ambari-server setup -s -j $JAVA_HOME


EXPOSE 8080 8440 8441

