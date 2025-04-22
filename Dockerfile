FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git curl zip unzip nano libpng-dev libonig-dev libxml2-dev libzip-dev \
    libjpeg-dev libfreetype6-dev libwebp-dev libxpm-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install pdo_mysql mbstring zip bcmath gd pcntl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Laravel installer
RUN composer global require laravel/installer

ENV PATH="/root/.composer/vendor/bin:${PATH}"

WORKDIR /var/www

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# ENTRYPOINT ["entrypoint.sh"]
