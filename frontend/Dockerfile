# Building the app
FROM node:24.5.0-alpine AS build-stage

# Setting working directory
WORKDIR /app

# Pass build-time arguments

# For vuejs env
ARG VITE_SERVER_IP
# For nginx.conf
ENV VITE_SERVER_IP=$VITE_SERVER_IP

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

RUN chmod +x /entrypoint.sh

# Expose port 80
EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]
