FROM danlsgiga/centos:latest as builder

ENV OPENSSL_VERSION="openssl-1.1.0g" NGINX_VERSION="nginx-1.13.8-1" MORE_HEADERS_VERSION="0.33" COOKIE_FLAG_BRANCH="master"

RUN yum -y groupinstall 'Development Tools' && \
    yum -y install wget redhat-lsb-core openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel pcre-devel unzip which && \    
    adduser builder

USER builder

RUN wget https://www.openssl.org/source/${OPENSSL_VERSION}.tar.gz -O /tmp/${OPENSSL_VERSION}.tar.gz && \
    tar -xvzf /tmp/${OPENSSL_VERSION}.tar.gz -C /tmp/ && \
    wget https://github.com/AirisX/nginx_cookie_flag_module/archive/${COOKIE_FLAG_BRANCH}.zip -O /tmp/nginx_cookie_flag_module.zip && \
    unzip /tmp/nginx_cookie_flag_module.zip -d /tmp/ && \
    wget https://github.com/openresty/headers-more-nginx-module/archive/v${MORE_HEADERS_VERSION}.tar.gz -O /tmp/more_headers-v${MORE_HEADERS_VERSION}.tar.gz && \
    tar -xvzf /tmp/more_headers-v${MORE_HEADERS_VERSION}.tar.gz -C /tmp/ && \
    rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/${NGINX_VERSION}.el7_4.ngx.src.rpm && \
    sed -i "s|--with-http_ssl_module|--with-http_ssl_module --with-openssl=/tmp/$OPENSSL_VERSION|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
    sed -i "s|--with-http_ssl_module|--with-http_ssl_module --add-dynamic-module=/tmp/headers-more-nginx-module-${MORE_HEADERS_VERSION}|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
    sed -i "s|--with-http_ssl_module|--with-http_ssl_module --add-dynamic-module=/tmp/nginx_cookie_flag_module-${COOKIE_FLAG_BRANCH}|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
    sed -i "s|%files|%files\n%{_libdir}/nginx/modules/ngx_http_headers_more_filter_module.so|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
    sed -i "s|%files|%files\n%{_libdir}/nginx/modules/ngx_http_cookie_flag_filter_module.so|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
    rpmbuild -ba /home/builder/rpmbuild/SPECS/nginx.spec

FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos - danlsgiga@gmail.com

COPY --from=builder /home/builder/rpmbuild/RPMS/x86_64/nginx-1*-1.el7_4.ngx.x86_64.rpm /tmp/
RUN yum -y install /tmp/nginx-1*-1.el7_4.ngx.x86_64.rpm && \
    rm -f /tmp/nginx-*-1.el7_4.ngx.x86_64.rpm

EXPOSE 80 443

STOPSIGNAL SIGTERM
ENTRYPOINT ["nginx", "-g", "daemon off;"]