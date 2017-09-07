FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos - danlsgiga@gmail.com

ARG OOKLA_INSTALL_SCRIPT_URL="http://install.speedtest.net/ooklaserver/ooklaserver.sh"

RUN yum -y update && \
    yum -y install tar gzip util-linux && \
    mkdir -p /opt/ookla && \
    useradd -MU -d /opt/ookla ookla && \
    yum -y erase util-linux && \
    yum clean all && \
    chown -R ookla.ookla /opt/ookla

USER ookla

RUN curl -s -L ${OOKLA_INSTALL_SCRIPT_URL} -o /opt/ookla/ooklaserver.sh && \
    chmod 750 /opt/ookla/ooklaserver.sh && \
    /opt/ookla/ooklaserver.sh install -f -i /opt/ookla && \
    /opt/ookla/ooklaserver.sh stop && \
    sed -e 's/.*OoklaServer.enableAutoUpdate.*/OoklaServer.enableAutoUpdate = false/' -i /opt/ookla/OoklaServer.properties

EXPOSE 8080 5060

ENTRYPOINT ["/bin/tini", "--"]
CMD ["/opt/ookla/OoklaServer", "start"]
