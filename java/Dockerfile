FROM danlsgiga/centos:latest

COPY server-jre-8u181-linux-x64.tar.gz /tmp/server-jre.tar.gz

RUN yum -y install tar gzip && \
    mkdir -p /opt/java && \
    tar --strip-components=1 -xvzf /tmp/server-jre.tar.gz -C /opt/java && \
    ln -s /opt/java/bin/java /usr/local/bin/java && \
    rm -f /tmp/server-jre.tar.gz

USER nobody

ENTRYPOINT ["/bin/tini", "--"]
CMD ["$0"]
