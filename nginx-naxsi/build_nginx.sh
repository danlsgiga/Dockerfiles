#!/bin/bash

set -e

wget https://www.openssl.org/source/${OPENSSL_VERSION}.tar.gz -O /tmp/${OPENSSL_VERSION}.tar.gz && \
tar -xvzf /tmp/${OPENSSL_VERSION}.tar.gz -C /tmp/ && \
wget https://github.com/nbs-system/naxsi/archive/${NAXSI_BRANCH}.zip -O /tmp/naxsi-${NAXSI_BRANCH}.zip && \
unzip /tmp/naxsi-${NAXSI_BRANCH}.zip -d /tmp/ && \
rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/${NGINX_VERSION}.el7.ngx.src.rpm && \
sed -i "s|--with-http_ssl_module|--with-http_ssl_module --with-openssl=/tmp/$OPENSSL_VERSION --add-dynamic-module=/tmp/naxsi-${NAXSI_BRANCH}/naxsi_src|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
sed -i "s|%files|%files\n%{_libdir}/nginx/modules/ngx_http_naxsi_module.so|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
rpmbuild -ba /home/builder/rpmbuild/SPECS/nginx.spec
