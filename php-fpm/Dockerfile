FROM php:7.4-fpm

ARG TIMEZONE

RUN apt-get update \
        && apt-get install -y libmcrypt-dev \
        && apt-get install -y libpng-dev \
        && apt-get install -y libpq-dev \
        && apt-get install -y libonig-dev \
        && apt-get install -y libxslt-dev \
        && apt-get install -y libcurl4-openssl-dev \
        && apt-get install -y libssl-dev \
        && apt-get install -y mc \
        && pecl install mcrypt-1.0.3 \
        && docker-php-ext-enable mcrypt \
        && pecl install mongodb \
        && docker-php-ext-enable mongodb \
        && docker-php-ext-install gd \
        && docker-php-ext-install pdo pdo_pgsql pdo_mysql xsl gd intl opcache exif mbstring \
        && apt-get install -y iputils-ping \
        && echo 'alias sf="php bin/console"' >> ~/.bashrc

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs
RUN rm nodesource_setup.sh

# Install yarn
RUN apt-get install -y gnupg

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn apt-key add - && \
echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && \
apt-get install -y --no-install-recommends yarn

# Install zip
RUN apt-get update \
     && apt-get install -y libzip-dev \
     && docker-php-ext-install zip

# Install supervisor
RUN apt-get update && \
    apt-get install -y \
    supervisor

# Install git
RUN apt-get install git -y

# Install amqp etc
RUN apt-get update \
    && apt-get install -y \
        librabbitmq-dev \
        libssh-dev \
    && docker-php-ext-install \
        bcmath \
        sockets \
    && pecl install amqp \
    && docker-php-ext-enable amqp

# Install redis
RUN pecl install redis && docker-php-ext-enable redis

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# install xdebug
RUN pecl install xdebug-3.0.3 \
        && docker-php-ext-enable xdebug

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone \
    && printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini \
    && "date"


COPY docker-entrypoint.sh /opt/docker-entrypoint.sh

WORKDIR  /var/www/symfony

ENTRYPOINT ["bash", "/opt/docker-entrypoint.sh"]

#CMD ["php-fpm"]

EXPOSE 9001
