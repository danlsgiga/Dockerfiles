FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos - danlsgiga@gmail.com

ENV TINI_VERSION="0.16.1"

RUN yum -y update && \
    yum -y install https://github.com/krallin/tini/releases/download/v0.16.1/tini_${TINI_VERSION}-amd64.rpm && \
    yum -y install https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.5.2-x86_64.rpm && \
    yum clean all && \
    mkdir -p /var/lib/filebeat /var/log/filebeat && \
    chown -R nobody.nobody /etc/filebeat /usr/share/filebeat /var/lib/filebeat /var/log/filebeat

USER nobody

ENTRYPOINT ["/bin/tini", "--"]

CMD ["/usr/share/filebeat/bin/filebeat", "-path.home", "/usr/share/filebeat", "-path.config", "/etc/filebeat", "-path.data", "/var/lib/filebeat", "-path.logs", "/var/log/filebeat", "$@"]
