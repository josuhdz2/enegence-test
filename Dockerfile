FROM node:20 AS node_builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

FROM composer:2 AS vendor_builder

WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader

COPY . .
RUN composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader

FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    libzip-dev \
    zip unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql zip \
    && apt-get clean

WORKDIR /var/www

COPY . .

COPY --from=vendor_builder /app/vendor ./vendor

COPY --from=node_builder /app/node_modules ./node_modules

RUN npm run build

RUN chown -R www-data:www-data \
    storage \
    bootstrap/cache

COPY ./docker/nginx.conf /etc/nginx/sites-available/default

COPY ./docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
