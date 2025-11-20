# Usa una imagen base de PHP, preferiblemente FPM para mejor rendimiento con Nginx
FROM php:8.2-fpm

# Instala dependencias del sistema y extensiones de PHP necesarias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql gd exif opcache

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configura el directorio de trabajo
WORKDIR /var/www/html

# La aplicación Laravel se montará aquí como un volumen en docker-compose
# Por ahora, solo copiamos el script de entrada (entrypoint) si fuera necesario, 
# pero para Laravel simple no lo es.

# Exponemos el puerto FPM
EXPOSE 9000

CMD ["php-fpm"]