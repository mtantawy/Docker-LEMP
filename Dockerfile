FROM ubuntu:latest

LABEL maintainer "me@mtantawy.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 \
    && echo 'deb http://nginx.org/packages/ubuntu/ xenial nginx' >> /etc/apt/sources.list.d/nginx.list \
    && apt-get update \
    && locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update

RUN apt-get install -y \
    nginx \
    vim \
    php7.1 \
    php7.1-cli \
    php7.1-fpm \
    mysql-server-5.7 \
    mysql-client-5.7 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./nginxDefault /etc/nginx/conf.d/default.conf
COPY ./nginxConf /etc/nginx/nginx.conf
COPY ./fastcgi_params /etc/nginx/fastcgi_params
COPY ./docker-run.sh /docker-run.sh

VOLUME ["/var/lib/mysql", "/var/www/html"]

EXPOSE 80

CMD ["/bin/bash", "docker-run.sh"]