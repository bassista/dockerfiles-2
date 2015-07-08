FROM bibryam/base:latest
MAINTAINER Bilgin Ibryam <bibryam@redhat.com>

# User root user to install software
USER root

# Install necessary packages
RUN yum -y install java-1.7.0-openjdk-devel && yum clean all

USER jboss

ENV JAVA_HOME /usr/lib/jvm/java
