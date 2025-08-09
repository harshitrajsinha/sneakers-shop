# Building the app
FROM node:24.5.0-alpine AS build-stage

# Setting working directory
WORKDIR /app

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

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
