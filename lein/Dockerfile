FROM danlsgiga/java:latest

COPY lein /usr/local/bin/lein

USER root

RUN mkdir -p /opt/lein && \
    chmod +x /usr/local/bin/lein && \
    chown nobody.nobody /opt/lein

USER nobody

ENV LEIN_HOME=/opt/lein
ENV _JAVA_OPTIONS=-Duser.home=/opt/lein

RUN lein

ENTRYPOINT ["/bin/tini"]
CMD ["$0"]
