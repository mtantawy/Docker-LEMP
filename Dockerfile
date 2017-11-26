FROM ubuntu:latest

LABEL maintainer "me@mtantawy.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes
ENV DOMAIN=SSL_DOMAIN

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 \
    && echo 'deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx' >> /etc/apt/sources.list.d/nginx.list \
    && apt-get update \
    && apt-get install locales \
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
    php7.1-curl \
    php7.1-fpm \
    php7.1-gd \
    php7.1-intl \
    php7.1-json \
    php7.1-mbstring \
    php7.1-mysql \
    php7.1-opcache \
    php7.1-xml \
    php7.1-zip \
    mysql-server-5.7 \
    mysql-client-5.7 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'sql-mode = "ONLY_FULL_GROUP_BY,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"' >> /etc/mysql/mysql.conf.d/mysqld.cnf

COPY ./nginx /etc/nginx
COPY ./docker-run.sh /docker-run.sh

VOLUME ["/var/lib/mysql", "/var/www/html", "/etc/nginx/ssl"]

EXPOSE 80 443

CMD ["/bin/bash", "docker-run.sh"]
