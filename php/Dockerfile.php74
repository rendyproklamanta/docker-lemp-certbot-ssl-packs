FROM php:7.4-fpm

RUN apt-get clean && apt-get update && apt-cache search php-mysql && apt-get install --fix-missing -y \
  ruby-dev \
  rubygems \
  imagemagick \
  graphviz \
  sudo \
  memcached \
  libmemcached-tools \
  libmemcached-dev \
  libpng-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libxml2-dev \
  libxslt1-dev \
  mariadb-client \
  linux-libc-dev \
  libyaml-dev \
  zlib1g-dev \
  libicu-dev \
  libpq-dev \
  bash-completion \
  htop \
  libldap2-dev \
  libssl-dev \
  libonig-dev \
  npm \
  libzip-dev \
  git \
  && rm -rf /var/lib/apt/lists/*

# Install others php modules
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install \
  gd \
  mbstring \
  zip \
  soap \
  pdo_mysql \
  mysqli \
  opcache \
  calendar \
  intl \
  exif \
  pgsql \
  pdo_pgsql \
  ftp \
  bcmath \
  ldap

RUN pecl install mcrypt-1.0.3 && \
  docker-php-ext-enable mcrypt

# Installation of Composer
RUN cd /usr/src && curl -sS http://getcomposer.org/installer | php
RUN cd /usr/src && mv composer.phar /usr/bin/composer

# TimeZone
RUN cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime \
  && echo "Asia/Jakarta" >  /etc/timezone

# # Install YAML extension
# RUN pecl install yaml-2.0.4 && echo "extension=yaml.so" > /usr/local/etc/php/conf.d/ext-yaml.ini

# # Install APCu extension
# RUN pecl install apcu-5.1.18

EXPOSE 9000

CMD ["php-fpm"]