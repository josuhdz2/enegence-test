# -------------------------------------------------------
# STAGE 1 — Node: solo instalar dependencias
# -------------------------------------------------------
FROM node:20 AS node_builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .


# -------------------------------------------------------
# STAGE 2 — Composer dependencies
# -------------------------------------------------------
FROM composer:2 AS vendor_builder

WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader

COPY . .
RUN composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader


# -------------------------------------------------------
# STAGE 3 — Imagen final (PHP-FPM + Nginx)
# -------------------------------------------------------
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

# Copiar proyecto
COPY . .

# Copiar vendors
COPY --from=vendor_builder /app/vendor ./vendor

# Copiar node_modules al final
COPY --from=node_builder /app/node_modules ./node_modules

# -------------------------------------------------------
# AHORA HACEMOS EL BUILD EN EL STAGE PHP
# -------------------------------------------------------
RUN npm run build

# Permisos
RUN chown -R www-data:www-data \
    storage \
    bootstrap/cache

# Copiar Nginx
COPY ./docker/nginx.conf /etc/nginx/sites-available/default

# Copiar Supervisor
COPY ./docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]
