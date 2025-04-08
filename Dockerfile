FROM php:8.3-apache

# Instalar dependencias del sistema y extensión DOM
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    zip \
    libxml2-dev \
    && docker-php-ext-install dom

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Establecer directorio de trabajo
WORKDIR /var/www/php-app

# 🔁 Copiar TODO el proyecto antes de instalar dependencias
COPY . .

# Instalar dependencias (incluye PHPUnit si está en composer.json)
RUN composer install

# Permisos (opcional)
RUN chown -R www-data:www-data /var/www/php-app

