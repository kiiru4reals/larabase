#!/bin/sh

cd /var/www || exit

composer install
composer install --ignore-platform-reqs

chown www-data:www-data vendor/
php artisan migrate

php artisan cache:clear
php artisan route:cache
php artisan config:clear
php artisan config:cache



/usr/bin/supervisord -c /etc/supervisord.conf