FROM centos:latest
MAINTAINER ken5

# Initial Setup
RUN yum -y update

# Import Certificates/GPG
RUN rpm --import \
    /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
    https://packages.elastic.co/GPG-KEY-elasticsearch
COPY elastic.repo /etc/yum.repos.d/

# Install
RUN yum -y install \
    squid \
    filebeat \
    epel-release

# set up EPEL For Supervisor(NEED this because we need to run squid + filebeat processes in One Container
# This is against Docker Best Practice, but currently there is no option to catch logs by filebeat
RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/epel.repo
RUN yum -y install --enablerepo=epel supervisor


# Set up squid
COPY squid.conf /etc/squid/squid.conf
COPY web_proxy_whitelists /etc/squid/
EXPOSE 3128

# Set up filebeat
COPY filebeat.yml /etc/filebeat/filebeat.yml

# COPY Certificates(Self-Signed). 
# Used for Client-authentication between this host and logstash server
COPY dont-reuse-this-self-signed.key /etc/pki/tls/certs/self-signed.key

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh 

EXPOSE 3128
ENTRYPOINT ["/sbin/entrypoint.sh"]
