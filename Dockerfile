# -------------------------------------------------------
# STAGE 1 – Compilar assets con Node
# -------------------------------------------------------
FROM node:20 AS node_builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build



# -------------------------------------------------------
# STAGE 2 – Instalar dependencias con Composer
# -------------------------------------------------------
FROM composer:2 AS vendor_builder

WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-scripts --no-interaction --prefer-dist

COPY . .
RUN composer install --no-dev --optimize-autoloader



# -------------------------------------------------------
# STAGE 3 – Imagen final: PHP-FPM + Nginx + Laravel
# -------------------------------------------------------
FROM php:8.2-fpm

# ---------------------------
# Instalar extensiones y Nginx
# ---------------------------
RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    libzip-dev zip unzip \
    && docker-php-ext-install pdo pdo_mysql zip \
    && apt-get clean

WORKDIR /var/www

# Copiar código del proyecto
COPY . .

# Copiar vendor desde stage 2
COPY --from=vendor_builder /app/vendor ./vendor

# Copiar assets compilados desde stage 1
COPY --from=node_builder /app/public/build ./public/build

# Permisos
RUN chown -R www-data:www-data \
    /var/www/storage \
    /var/www/bootstrap/cache

# ---------------------------
# Configuración de Nginx
# ---------------------------
COPY ./docker/nginx.conf /etc/nginx/sites-available/default

# ---------------------------
# Configurar Supervisor (manejar PHP-FPM + Nginx)
# ---------------------------
COPY ./docker/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

EXPOSE 80

CMD ["/usr/bin/supervisord"]
