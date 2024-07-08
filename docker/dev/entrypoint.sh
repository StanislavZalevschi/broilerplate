#!/bin/bash

set -eo pipefail

if [[ ! -f ".env" ]]
then
    echo "Warning: .env not found."
    cp .env.example .env
fi
#convert to Unix format
dos2unix .env

if [[ -z "$APP_KEY" ]]
then
    php artisan key:generate
fi

php artisan storage:link --force

php artisan migrate
php artisan permissions:refresh

php artisan jwt:secret

php artisan schedule:run

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf

exit 0