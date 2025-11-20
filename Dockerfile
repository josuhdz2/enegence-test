FROM php:8.3-fpm

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpq-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring

# Instalar Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Configuración de la app
WORKDIR /var/www

COPY --chown=www-data:www-data . .

RUN composer install --no-interaction --prefer-dist --optimize-autoloader

CMD ["php-fpm"]
