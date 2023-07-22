FROM php:8.2.8-cli

ENV DEBIAN_FRONTEND noninteractive
ENV TERM            xterm-color

ARG DEV_MODE
ENV DEV_MODE $DEV_MODE

COPY ./rootfilesystem/ /

RUN apt-get update \
  && apt-get install -y \
             apt-utils \
             man \
             curl \
             git \
             bash \
             vim \
             zip unzip \
             acl \
             iproute2 \
             dnsutils \
             fonts-freefont-ttf \
             fontconfig \
             dbus \
             openssh-client \
             sendmail \
             libfreetype6-dev \
             libjpeg62-turbo-dev \
             icu-devtools \
             libicu-dev \
             libmcrypt4 \
             libmcrypt-dev \
             libpng-dev \
             zlib1g-dev \
             libxml2-dev \
             libzip-dev \
             libonig-dev \
             graphviz \
             libcurl4-openssl-dev \
             pkg-config \
             libldap2-dev \
             libpq-dev \
             libyaml-dev \
             supervisor \
             g++\
             wget \
             gcc \
             libmemcached-dev \
             libssl-dev \
    && pecl install openswoole \
    && docker-php-ext-enable openswoole \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && pecl install yaml \
    && docker-php-ext-enable yaml

RUN docker-php-ext-configure intl --enable-intl && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install pdo \
        pgsql pdo_pgsql \
        mysqli pdo_mysql \
        intl iconv mbstring \
        zip pcntl \
        exif opcache \
	&& docker-php-ext-enable opcache


RUN docker-php-ext-install sockets
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install bcmath

RUN pecl install memcached && \
    docker-php-ext-enable memcached

RUN docker-php-source delete
	
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

#COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Добавим свой php.ini, можем в нем определять свои значения конфига
ADD php.ini /usr/local/etc/php/php.ini

# Set working directory
WORKDIR /var/www/html

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]