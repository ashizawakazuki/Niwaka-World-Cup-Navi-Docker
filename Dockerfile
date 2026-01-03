FROM php:8.2-apache

WORKDIR /var/www/html

#smartyを導入するためのcomposerを使えるようにする
RUN apt-get update \
    && apt-get install -y unzip curl \
    && curl -sS https://getcomposer.org/installer | php -- \
    && mv composer.phar /usr/local/bin/composer