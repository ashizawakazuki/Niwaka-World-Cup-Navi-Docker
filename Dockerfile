FROM php:8.2-apache

WORKDIR /var/www/html

#smartyを導入するためのcomposerを使えるようにする
RUN apt-get update \
    && apt-get install -y unzip curl \
    && curl -sS https://getcomposer.org/installer | php -- \
    && mv composer.phar /usr/local/bin/composer

#デバッカーの追加（GPTより）
# Xdebug インストール
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Xdebug 設定
RUN echo "zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Docker の中の PHP に “MySQL と通信するための機能を追加(GPTより）
RUN docker-php-ext-install pdo pdo_mysql
