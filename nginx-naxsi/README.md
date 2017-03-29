## Build the docker image:

`$ docker build . -t danlsgiga/nginx-naxsi:latest`

## Run the nginx compilation like this:

`$ docker run --name nginx-naxsi -e NGINX_VERSION=nginx-1.11.12-1 -e OPENSSL_VERSION=openssl-1.1.0e -e NAXSI_BRANCH=master danlsgiga/nginx-naxsi`

## To copy the ngx_http_naxsi_module.so module:

`$ docker cp nginx-naxsi:/home/builder/rpmbuild/BUILD/nginx-1.11.12/objs/ngx_http_naxsi_module.so .`

## To copy the RPM package generated:

`$ docker cp nginx-naxsi:/home/builder/rpmbuild/RPMS/x86_64/nginx-1.11.12-1.el7.centos.ngx.x86_64.rpm .`
