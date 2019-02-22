FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos <danlsgiga@gmail.com>

RUN yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-2018.3-1.el7.noarch.rpm && \
    yum -y install salt-master salt-minion vim nano wget unzip && \
    yum clean all && \
    curl -L https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip -o /tmp/terraform.zip && \
    unzip /tmp/terraform.zip -d /usr/local/bin/ && \
    rm -f /tmp/terraform.zip && \
    echo "master: localhost" > /etc/salt/minion.d/master.conf && \
    echo "auto_accept: True" > /etc/salt/master.d/autoaccept.conf

COPY salt /srv/salt
COPY run-salt /usr/local/bin/run-salt
COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/bin/tini", "--", "/opt/entrypoint.sh"]
