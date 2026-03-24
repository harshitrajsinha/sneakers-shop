# Building the app
FROM node:24-alpine AS build-stage

# Setting working directory
WORKDIR /app

# Pass build-time arguments

# # For vuejs env
# ARG NGINX_SERVER
ARG VITE_BACKEND_SOCKET
ARG VITE_PAYMENT_SOCKET
ENV VITE_BACKEND_SOCKET=$VITE_BACKEND_SOCKET
ENV VITE_PAYMENT_SOCKET=$VITE_PAYMENT_SOCKET

COPY package*.json ./

# Install dependencies
RUN npm install

COPY . .

# Build first layer
RUN npm run build

# Serving app with Nginx
FROM nginx:stable-alpine AS production-stage

# Copy only build files
COPY --from=build-stage /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/templates/nginx.conf
COPY entrypoint.sh /

# COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /entrypoint.sh

# Expose port 80
EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]
# ENTRYPOINT ["nginx", "-g", "daemon off;"]
