FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos <danlsgiga@gmail.com>

RUN yum -y update && \
    curl -o /tmp/bootstrap-salt.sh -L https://bootstrap.saltstack.com && \
    sh /tmp/bootstrap-salt.sh -X git 2016.11 && \
    mkdir -p /srv/salt && \
    sed -i 's/#file_client: remote/file_client: local/g' /etc/salt/minion && \
    cd /tmp && curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k http://download.oracle.com/otn-pub/java/jdk/8u112-b15/server-jre-8u112-linux-x64.tar.gz && \
    yum clean all
    
COPY jre.sls /srv/salt/

CMD ["/usr/bin/salt-call", "--local", "state.apply", "jre"]
