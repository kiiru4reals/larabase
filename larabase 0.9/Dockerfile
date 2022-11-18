FROM php:7.4-fpm

RUN mkdir -p /var/www/

# Set working directory
WORKDIR /var/www

# Add docker php ext repo
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install php extensions
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mbstring pdo_mysql zip exif pcntl gd memcached

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    jpegoptim optipng pngquant \
    curl \
    libmemcached-dev \
    nginx \ 
    supervisor

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Copy nginx/php/supervisor configs
COPY  ./docker/prod/supervisor.conf /etc/supervisord.conf
COPY ./docker/prod/php.ini /usr/local/etc/php/conf.d/app.ini
COPY ./docker/prod/nginx.conf /etc/nginx/sites-enabled/default


# Storage log files
RUN mkdir /var/www/storage/
RUN mkdir /var/www/storage/logs
RUN touch /var/www/storage/logs/laravel.log

# PHP Error Log Files
RUN mkdir /var/log/php
RUN chmod -R 777 /var/log/php/
RUN touch /var/log/php/errors.log && chmod 777 /var/log/php/errors.log
RUN touch /var/log/nginx/access.log  && touch /var/log/nginx/schedule.log && touch /var/log/nginx/notification.log && touch /var/log/nginx/worker.log && chmod 777 /var/log/nginx/*.log
RUN chown -R www-data:www-data /var/www/
RUN chown www-data:www-data /var/log/*.log

# Deployment steps
EXPOSE 8000