#!/usr/bin/env bash

export APP_ENV=${APP_ENV:-local}
export APP_PORT=${APP_PORT:-80}
export API_PORT=${API_PORT:-3000}
export DB_PORT=${DB_PORT:-3306}
export DB_ROOT_PASS=${DB_ROOT_PASS:-secret}
export DB_NAME=${DB_NAME:-helpspot}
export DB_USER=${DB_USER:-helpspot}
export DB_PASS=${DB_PASS:-secret}

# Decide which docker-compose file to use
COMPOSE_FILE="dev"
# Disable pseudo-TTY allocation for CI (Jenkins)
TTY=""

if [ ! -z "$BUILD_NUMBER" ]; then
#    COMPOSE_FILE="ci"
    TTY="-T"
fi

#COMPOSE="docker-compose -f docker-compose.${COMPOSE_FILE}.yml"
COMPOSE="docker-compose"

if [ $# -gt 0 ]; then
    if [ "$1" == "art" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            app \
            php artisan "$@"
    elif [ "$1" == "composer" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            app \
            composer "$@"
    elif [ "$1" == "yarn" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            node \
            yarn "$@"
    elif [ "$1" == "test" ]; then
        shift 1
        $COMPOSE run --rm \
        -w /var/www/html \
        app \
        ./vendor/bin/phpunit "$@"
    elif [ "$1" == "t" ]; then
        shift 1
        $COMPOSE exec \
        app \
        sh -c "cd /var/www/html && ./vendor/bin/phpunit $@"
    elif [ "$1" == "e2e" ]; then
        shift 1

        if [ $# -gt 0 ]; then
            $COMPOSE run --rm \
            codeceptjs \
            codeceptjs "$@"
        else
        sh -c "echo ${APP_PORT}"
            $COMPOSE up -d
            $COMPOSE run --rm \
                chrome \
                sh -c "./node_modules/.bin/codeceptjs run --debug"
            $COMPOSE down
        fi
    else
        $COMPOSE "$@"
    fi
else
    $COMPOSE ps
fi
