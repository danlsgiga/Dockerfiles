FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos <dasanto2@cisco.com>

RUN yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-2017.7-1.el7.noarch.rpm && \
    yum -y install salt-master salt-minion vim nano wget && \
    sed -i 's/#master: salt/master: localhost/g' /etc/salt/minion

COPY salt /srv/salt
COPY run-salt /usr/local/bin/run-salt
