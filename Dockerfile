FROM centos:latest
MAINTAINER ken5scal

ENV FILE_BEAT_VER = 5.0.0

RUN yum -y update && yum install -y \
    which
