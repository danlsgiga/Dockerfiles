FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos - danlsgiga@gmail.com

ENV OPENSSL_VERSION="openssl-1.1.0e" NGINX_VERSION="nginx-1.12.0-1" NGINX_SERVER_HEADER="nginx" NAXSI_BRANCH="http2" MORE_HEADERS_VERSION="0.32"

RUN yum -y update && \
    yum -y groupinstall 'Development Tools' && \
    yum -y install wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel pcre-devel unzip which && \
    yum clean all && \
    adduser builder

USER builder

COPY build_nginx.sh /usr/bin/build_nginx

ENTRYPOINT ["/usr/bin/build_nginx"]