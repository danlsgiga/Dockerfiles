FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos <danlsgiga@gmail.com>

RUN yum -y update && \
    curl -o /tmp/bootstrap-salt.sh -L https://bootstrap.saltstack.com && \
    sh /tmp/bootstrap-salt.sh -X && \
    mkdir -p /srv/salt && \
    sed -i 's/#file_client: remote/file_client: local/g' /etc/salt/minion && \
    yum clean all
    
COPY graylog.sls /srv/salt/

CMD ["/usr/bin/salt-call", "--local", "state.apply", "graylog"]
