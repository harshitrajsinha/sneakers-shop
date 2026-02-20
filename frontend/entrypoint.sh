#!/bin/sh
envsubst '${VITE_SERVER_IP}' < /etc/nginx/templates/nginx.conf > /etc/nginx/conf.d/default.conf
nginx -g "daemon off;"