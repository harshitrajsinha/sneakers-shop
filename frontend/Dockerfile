# Building the app
FROM node:24-alpine AS build-stage

# Setting working directory
WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm install

COPY . .

# Provides envsubst
RUN apk add --no-cache gettext

# Generate nginx.conf from template
RUN envsubst '$NGINX_SERVER' < nginx.conf.template > nginx.conf

# Build first layer
RUN npm run build

# Serving app with Nginx
FROM nginx:stable-alpine AS production-stage

# Copy only build files
COPY --from=build-stage /app/dist /usr/share/nginx/html

COPY --from=build-stage /app/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
