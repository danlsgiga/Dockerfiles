FROM danlsgiga/centos:latest
MAINTAINER "Daniel Santos" <danlsgiga@gmail.com>

RUN yum -y update && \
    yum -y install epel-release \
                   yum-utils \
                   http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php71 && \
    yum -y install php-fpm \
                   php-mbstring \
                   php-mysql \
                   php-gd \
                   httpd \
                   mod_ssl \
                   supervisor && \
    yum clean all && \
    sed -e 's/127.0.0.1:9000/9000/' \ 
        -e '/allowed_clients/d' \
        -e '/catch_workers_output/s/^;//' \
        -e '/error_log/d' \
        -e '/user/d' \
        -e '/group/d' \
        -e 's/.*php_flag\[display_errors\].*/php_flag\[display_errors\] = on/' \
        -i /etc/php-fpm.d/www.conf && \
    sed -e 's/80/8080/' -e 's/.*ServerName.*:/ServerName 127.0.0.1:/' -i /etc/httpd/conf/httpd.conf && \ 
    sed -e 's/443/4443/' -i /etc/httpd/conf.d/ssl.conf && \ 
    echo "LoadModule mpm_event_module modules/mod_mpm_event.so" > /etc/httpd/conf.modules.d/00-mpm.conf && \ 
    usermod -s /bin/bash apache
 
COPY supervisord.ini /etc/supervisord.d/supervisord.ini
COPY httpd_vhost.conf /etc/httpd/conf.d/php.conf
COPY mysql_test.php /var/www/html/index.php

RUN chown -R apache.apache /var/www/html \
                           /etc/{supervisor*,pki/tls} \
                           /var/log/{php-fpm,httpd,supervisor} \
                           /var/run/{php-fpm,httpd,supervisor} && \
    find / -type d -name proc -prune -o -perm /6000 -type f -exec chmod a-s {} \;

USER apache

EXPOSE 8080

CMD ["/bin/supervisord"]
