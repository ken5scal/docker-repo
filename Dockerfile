FROM centos:latest
MAINTAINER ken5scal

ENV FILE_BEAT_VER 5.0.0
ENV FILE_BEAT_URL https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILE_BEAT_VER}-`uname -m`.rpm

RUN yum -y update && yum install -y \
    which

RUN curl -L -O ${FILE_BEAT_URL} && \
    rpm -vi filebeat-${FILE_BEAT_VER}-`uname -m`.rpm
