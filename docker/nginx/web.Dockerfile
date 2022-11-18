FROM nginx:stable-alpine

RUN sed -i "s/user  nginx/user root/g" /etc/nginx/nginx.conf

ADD vhost.conf /etc/nginx/conf.d/default.conf
