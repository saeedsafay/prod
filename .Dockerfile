FROM php:7.2-apache

RUN apt-get update
RUN apt-get install -y memcached libmemcached-tools
RUN apt-get install -y git
RUN apt-get install -y libmcrypt-dev
RUN apt-get install -y libpng-dev
RUN apt-get install -y libmagickwand-dev
RUN apt-get install -y zip unzip

RUN pecl install xdebug
RUN pecl install imagick
RUN docker-php-ext-enable xdebug
RUN docker-php-ext-enable imagick

RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-install gd

RUN a2enmod rewrite
RUN service apache2 restart

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www/html/

# Change current user to www
USER www

# RUN composer install
RUN ls -la