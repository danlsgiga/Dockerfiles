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
                   php-gd && \
    yum clean all && \
    sed -e 's/127.0.0.1:9000/9000/' \ 
        -e '/allowed_clients/d' \
        -e '/catch_workers_output/s/^;//' \
        -e '/error_log/d' \
        -e '/user/d' \
        -e '/group/d' \
        -i /etc/php-fpm.d/www.conf && \
    mkdir -p /var/www/html && \
    useradd -MU -d /var/www/html php-fpm && \
    chown -R php-fpm.php-fpm /var/www/html /var/log/php-fpm /run/php-fpm && \
    find / -type d -name proc -prune -o -perm /6000 -type f -exec chmod a-s {} \;
USER php-fpm
EXPOSE 9000
CMD /usr/sbin/php-fpm --nodaemonize
