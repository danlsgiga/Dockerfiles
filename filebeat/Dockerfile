FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos - danlsgiga@gmail.com

ENV FILEBEAT_VERSION="5.5.2"

RUN yum -y update && \    
    yum -y install https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.rpm && \
    yum clean all && \
    mkdir -p /var/lib/filebeat /var/log/filebeat && \
    chown -R nobody.nobody /etc/filebeat /usr/share/filebeat /var/lib/filebeat /var/log/filebeat

USER nobody

ENTRYPOINT ["/bin/tini", "/usr/share/filebeat/bin/filebeat", "--", "-path.home", "/usr/share/filebeat", "-path.config", "/etc/filebeat", "-path.data", "/var/lib/filebeat", "-path.logs", "/var/log/filebeat"]
CMD ["$0"]
