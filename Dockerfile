#
# 
# DOCKER-VERSION    1.7.1
#
# Dockerizing CentOS7: Dockerfile for building CentOS images
#
FROM       centos  
MAINTAINER qiuyinggang <qiuyinggang@3mang.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
ENV DATA_DIR /var/lib/mysql
ENV TOMCAT_HOME=/usr/local/tomcat
ENV JAVA_HOME /usr/local/jdk1.7.0_79
ENV PATH $PATH:$JAVA_HOME/bin
ADD aliyun-mirror.repo /etc/yum.repos.d/CentOS-Base.repo
ADD aliyun-epel.repo /etc/yum.repos.d/epel.repo
RUN yum install -y mariadb mariadb-server && \
    yum install -y python-setuptools && \
    yum clean all
RUN easy_install supervisor
ADD jdk-7u79-linux-x64.tar.gz /usr/local/
ADD mysqld_charset.cnf /etc/my.cnf.d/
RUN mkdir -p /opt/cachecloud-web/logs
ADD supervisord.conf /etc/supervisord.conf
RUN mkdir -p /var/log/supervisor
#ADD mysql-run.sh /mysql-run.sh
#ADD tomcat-run.sh /tomcat-run.sh
#RUN mkdir -p /etc/supervisor.conf.d/
#ADD supervisord-mysql.conf /etc/supervisor.conf.d/supervisord-mysql.conf
#ADD supervisord-tomcat.conf /etc/supervisor.conf.d/supervisord-tomcat.conf
#RUN chmod +x /*.sh
COPY scripts /scripts
RUN chmod +x /scripts/start.*

EXPOSE 3306 8080

VOLUME ["/var/lib/mysql"]
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

