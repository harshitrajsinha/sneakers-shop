#!/bin/sh
envsubst '${VITE_BACKEND_SOCKET}' < /etc/nginx/templates/nginx.conf > /etc/nginx/conf.d/default.conf
nginx -g "daemon off;"