#!/bin/sh
set -e

if [ -z "$SERVE_PORT" ]
then
    echo "SERVE_PORT environment variable not set"
    exit 1
fi


if [ "$1" = "server" ]
then
    python /opt/app/manage.py runserver 0.0.0.0:$SERVE_PORT
fi

exec "$@"
