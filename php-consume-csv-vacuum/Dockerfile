FROM alpine:edge

LABEL maintainer="Vincent Composieux <vincent.composieux@gmail.com>"

RUN apk update && apk upgrade && \
    apk add --update --no-cache --update-cache vips-dev fftw-dev build-base \
    --repository https://alpine.global.ssl.fastly.net/alpine/v3.10/community/ \
    --repository https://alpine.global.ssl.fastly.net/alpine/v3.10/main

RUN apk add --update --no-cache \
    coreutils \
    php7-fpm \
    php7-apcu \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-gd \
    php7-iconv \
    php7-json \
    php7-intl \
    php7-mcrypt \
    php7-fileinfo\
    php7-mbstring \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-mysqli \
    php7-pdo_pgsql \
    php7-pgsql \
    php7-xml \
    php7-zlib \
    php7-phar \
    php7-tokenizer \
    php7-session \
    php7-simplexml \
    php7-xdebug \
    php7-zip \
    php7-xmlwriter \
    make \
    curl \
    zlib-dev \
    libxml2-dev \
    rabbitmq-c-dev \
    oniguruma-dev \
    php7-pecl-amqp \
    php7-amqp \
    php7-redis \
    openrc --no-cache \
    supervisor

RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ php7-pecl-mongodb

COPY docker-entrypoint.sh /opt/docker-entrypoint.sh

RUN echo "$(curl -sS https://composer.github.io/installer.sig) -" > composer-setup.php.sig \
        && curl -sS https://getcomposer.org/installer | tee composer-setup.php | sha384sum -c composer-setup.php.sig \
        && php composer-setup.php --version=1.10.10 && rm composer-setup.php* \
        && chmod +x composer.phar && mv composer.phar /usr/bin/composer && chmod +x /opt/docker-entrypoint.sh

COPY symfony.ini /etc/php7/conf.d/
COPY symfony.ini /etc/php7/cli/conf.d/
COPY xdebug.ini  /etc/php7/conf.d/

COPY symfony.pool.conf /etc/php7/php-fpm.d/

WORKDIR /var/www/symfony

ENTRYPOINT ["ash", "/opt/docker-entrypoint.sh"]

EXPOSE 9001
