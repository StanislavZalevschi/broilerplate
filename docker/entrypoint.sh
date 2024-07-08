#!/bin/bash

#set -eo pipefail

if [[ ! -f ".env" ]]
then
    echo "Warning: .env not found."
    cp .env.example .env
fi

source .env

if [[ ! -d "storage" ]]
then
    mkdir -p storage/app
    mkdir -p storage/framework/{cache,sessions,views}
    mkdir -p storage/logs

    touch storage/logs/laravel.log
    echo "Logs start ..." > storage/logs/laravel.log
fi

composer install

if [[ -z "$APP_KEY" ]]
then
    php artisan key:generate
fi

if [ "$APP_ENV" == "local" ]; then
    php artisan telescope:publish
fi

php artisan storage:link --force

php artisan migrate
php artisan permissions:refresh

chown -R nginx:nginx .

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

exit 0
