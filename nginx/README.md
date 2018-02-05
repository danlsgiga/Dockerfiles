## Build the docker image:

`$ docker build . -t danlsgiga/nginx:latest`

## Run the nginx compilation like this:

`$ docker run --name nginx -e NGINX_VERSION=nginx-1.13.8-1 -e OPENSSL_VERSION=openssl-1.1.0g -e MORE_HEADERS_VERSION=0.32 -e COOKIE_FLAG="master" danlsgiga/nginx`
