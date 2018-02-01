#!/bin/bash

set -e

wget https://www.openssl.org/source/${OPENSSL_VERSION}.tar.gz -O /tmp/${OPENSSL_VERSION}.tar.gz && \
tar -xvzf /tmp/${OPENSSL_VERSION}.tar.gz -C /tmp/ && \
#wget https://github.com/danlsgiga/naxsi/archive/${NAXSI_BRANCH}.zip -O /tmp/naxsi-${NAXSI_BRANCH}.zip && \
#unzip /tmp/naxsi-${NAXSI_BRANCH}.zip -d /tmp/ && \
wget https://github.com/danlsgiga/nginx_cookie_flag_module/archive/${COOKIE_FLAG_BRANCH}.zip -O /tmp/nginx_cookie_flag_module.zip && \
unzip /tmp/nginx_cookie_flag_module.zip -d /tmp/ && \
wget https://github.com/danlsgiga/headers-more-nginx-module/archive/v${MORE_HEADERS_VERSION}.tar.gz -O /tmp/more_headers-v${MORE_HEADERS_VERSION}.tar.gz && \
tar -xvzf /tmp/more_headers-v${MORE_HEADERS_VERSION}.tar.gz -C /tmp/ && \
rpm -ivh http://nginx.org/packages/mainline/centos/7/SRPMS/${NGINX_VERSION}.el7.ngx.src.rpm && \
sed -i "s|--with-http_ssl_module|--with-http_ssl_module --with-openssl=/tmp/$OPENSSL_VERSION|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
#sed -i "s|--with-http_ssl_module|--with-http_ssl_module --add-dynamic-module=/tmp/naxsi-${NAXSI_BRANCH}/naxsi_src|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
sed -i "s|--with-http_ssl_module|--with-http_ssl_module --add-dynamic-module=/tmp/headers-more-nginx-module-${MORE_HEADERS_VERSION}|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
sed -i "s|--with-http_ssl_module|--with-http_ssl_module --add-dynamic-module=/tmp/nginx_cookie_flag_module-${COOKIE_FLAG_BRANCH}|g" /home/builder/rpmbuild/SPECS/nginx.spec && \

#sed -i "s|%files|%files\n%{_libdir}/nginx/modules/ngx_http_naxsi_module.so|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
sed -i "s|%files|%files\n%{_libdir}/nginx/modules/ngx_http_headers_more_filter_module.so|g" /home/builder/rpmbuild/SPECS/nginx.spec && \
sed -i "s|%files|%files\n%{_libdir}/nginx/modules/ngx_http_cookie_flag_filter_module.so|g" /home/builder/rpmbuild/SPECS/nginx.spec && \

rpmbuild -ba /home/builder/rpmbuild/SPECS/nginx.spec
