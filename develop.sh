#!/usr/bin/env bash

export APP_PORT=${APP_PORT:-80}

COMPOSE_FILE="dev"

COMPOSE="docker-compose -f docker-compose.${COMPOSE_FILE}.yml"

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
    elif [ "$1" == "npm" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            node \
            npm "$@"
    else
        $COMPOSE "$@"
    fi
else
    $COMPOSE ps
fi
