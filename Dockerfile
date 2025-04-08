FROM php:8.3-apache

# Instalar extensiones necesarias del sistema y PHP
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libxml2-dev \
    zip \
    && docker-php-ext-install dom

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Copiar archivos necesarios para instalar dependencias primero
WORKDIR /var/www/html
COPY composer.json composer.lock ./

# Instalar dependencias PHP (incluye PHPUnit si está en composer.json)
RUN composer install

# Copiar el resto del proyecto (código fuente, tests, etc.)
COPY . .

# Establecer permisos (opcional)
RUN chown -R www-data:www-data /var/www/html

