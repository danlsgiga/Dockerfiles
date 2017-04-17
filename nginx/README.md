## Build the docker image:

`$ docker build . -t danlsgiga/nginx:latest`

## Run the nginx compilation like this:

`$ docker run --name nginx -e NGINX_VERSION=nginx-1.12.0-1 -e OPENSSL_VERSION=openssl-1.1.0e -e NGINX_SERVER_HEADER=nginx -e NAXSI_BRANCH=master -e MORE_HEADERS_VERSION=0.32 danlsgiga/nginx`

## To copy the ngx_http_naxsi_module.so module:

`$ docker cp nginx:/home/builder/rpmbuild/BUILD/nginx-1.12.0/objs/ngx_http_naxsi_module.so .`

## To copy the ngx_http_headers_more_filter_module.so module:

`$ docker cp nginx:/home/builder/rpmbuild/BUILD/nginx-1.12.0/objs/ngx_http_headers_more_filter_module.so .`

## To copy the RPM package generated:

`$ docker cp nginx:/home/builder/rpmbuild/RPMS/x86_64/nginx-1.12.0-1.el7.centos.ngx.x86_64.rpm .`
