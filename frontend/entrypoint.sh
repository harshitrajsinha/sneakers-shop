#!/bin/sh
envsubst < /etc/nginx/templates/nginx.conf > /etc/nginx/conf.d/default.conf
exec nginx -g "daemon off;"