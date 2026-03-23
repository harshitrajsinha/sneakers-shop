#!/bin/sh
set -e

envsubst < /etc/nginx/templates/nginx.conf.template > /etc/nginx/conf.d/default.conf
envsubst < /usr/share/nginx/html/config.js.template > /usr/share/nginx/html/config.js

exec nginx -g "daemon off;"