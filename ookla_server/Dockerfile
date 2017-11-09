FROM danlsgiga/centos:latest
MAINTAINER Daniel Santos - danlsgiga@gmail.com

ARG OOKLA_INSTALL_SCRIPT_URL="http://install.speedtest.net/ooklaserver/ooklaserver.sh"
ARG OOKLA_LEGACY_FALLBACK_FILES_URL="http://install.speedtest.net/httplegacy/http_legacy_fallback.zip"

RUN yum -y update && \
    yum -y install epel-release \
                   yum-utils \
                   http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
    yum-config-manager --enable remi-php71 && \
    yum -y install tar \
                   gzip \
                   unzip \                   
                   php-fpm \
                   php-mbstring \
                   php-mysql \
                   php-gd \
                   httpd \
                   mod_ssl \
                   supervisor && \
    sed -e '/allowed_clients/d' \
        -e '/catch_workers_output/s/^;//' \
        -e '/error_log/d' \
        -e '/user/d' \
        -e '/group/d' \        
        -i /etc/php-fpm.d/www.conf && \
    sed -e 's/80/8000/' -e 's/.*ServerName.*:/ServerName 127.0.0.1:/' -i /etc/httpd/conf/httpd.conf && \ 
    sed -e 's/443/4443/' -i /etc/httpd/conf.d/ssl.conf && \ 
    echo "LoadModule mpm_event_module modules/mod_mpm_event.so" > /etc/httpd/conf.modules.d/00-mpm.conf && \ 
    usermod -s /bin/bash apache && \    
    mkdir -p /opt/ookla && \    
    yum clean all && \
    rm -rf /var/cache/yum

COPY supervisord.ini /etc/supervisord.d/supervisord.ini
COPY httpd_vhost.conf /etc/httpd/conf.d/php.conf

RUN chown -R apache.apache /var/www/html \
                           /etc/{supervisor*,pki/tls} \
                           /var/log/{php-fpm,httpd,supervisor} \
                           /var/run/{php-fpm,httpd,supervisor} \
                           /opt/ookla && \
    find / -type d -name proc -prune -o -perm /6000 -type f -exec chmod a-s {} \; && \
    find /var/www/html -type d -exec chmod 2755 {} \; && \
    find /var/www/html -type f -exec chmod 2644 {} \;

USER apache

RUN curl -s -L ${OOKLA_INSTALL_SCRIPT_URL} -o /opt/ookla/ooklaserver.sh && \
    curl -s -L ${OOKLA_LEGACY_FALLBACK_FILES_URL} -o /tmp/http_legacy_fallback.zip && \
    chmod 750 /opt/ookla/ooklaserver.sh && \
    /opt/ookla/ooklaserver.sh install -f -i /opt/ookla && \
    /opt/ookla/ooklaserver.sh stop && \
    sed -e 's/.*OoklaServer.enableAutoUpdate.*/OoklaServer.enableAutoUpdate = false/' -i /opt/ookla/OoklaServer.properties && \
    unzip /tmp/http_legacy_fallback.zip -d /var/www/html/ && \
    rm -f /tmp/http_legacy_fallback.zip

EXPOSE 8000 8080 5060

ENTRYPOINT ["/bin/tini", "--"]
CMD ["/bin/supervisord"]
