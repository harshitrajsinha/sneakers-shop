## Sneakers Shop

- microservice sneakers application
- Frontend: Vue => SPA -> List all sneaker products
- Backend: Golang => Serves REST API for all products, product details
- Payment: Golang => Add entry to database, no real implementation
- Logs & Analytics: Python => Shows most purchased products in last 10 mins (JSON format)
- Database: PostgreSQL => Contains product, logs data

![Sneakers](./Screenshot%202025-08-09%20120056.png)

## Service URLs

- Frontend: http://localhost:3000
- Backend API: http://localhost:8080/api
- Payment API: http://localhost:8081/api
- Logging API: http://localhost:8082/api
- Analytics API: http://localhost:8083/api, http://localhost:8083/api/analytics/dashboard

### Image build

- network: docker network create sneakers-shop-net
- database: docker build -t sneaker-database .
- backend: docker build --build-arg NGINX_SERVER=localhost:3000 -t sneaker-backend .
- frontend: docker build -t sneaker-frontend .
- payment: docker build -t sneaker-payment .
- logs: docker build -t sneaker-logs .
- analytics: docker build -t sneaker-analytics .

### Container Run

- database: docker run --name sneakerdb --network sneakers-shop-net -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 sneaker-database
- backend: docker run --name sneaker-backend --network sneakers-shop-net -e FRONTEND_SOCKET=http://localhost:3000 -e DATABASE_HOST=sneakerdb -p 8080:8080 sneaker-backend
- backend: docker run --name sneaker-backend --cpus="1.0" -m 100m --network sneakers-shop-net -e FRONTEND_SOCKET=http://localhost:3000 -p 8080:8080 sneaker-backend
- frontend: docker run --name sneaker-frontend -d -p 3000:80 -e VITE_BACKEND_SOCKET=http://localhost:8080 -e VITE_PAYMENT_SOCKET=http://localhost:8081 sneaker-frontend
- payment: docker run --name sneaker-payment --network sneakers-shop-net -p 8081:8081 -e DATABASE_HOST=sneakerdb -e FRONTEND_SOCKET=http://localhost:3000 sneaker-payment
- logs: docker run --name sneaker-logs --network sneakers-shop-net -p 8082:8082 -e DATABASE_HOST=sneakerdb sneaker-logs
- analytics: docker run --name sneaker-analytics --network sneakers-shop-net -p 8083:8083 -e DATABASE_HOST=sneakerdb sneaker-analytics
- loadbalancer: docker run --name nginx-lb -p 8080:80 -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro nginx:latest

docker exec -it <container-name-or-id> psql -U $POSTGRES_USER -d $POSTGRES_DB
* Here POSTGRES_DB = sneaker_db 

docker exec -it <container-name-or-id> sh
* sh => shell

### Testing and Monitoring

- docker stats

- Locust: docker run --name locust -p 8089:8089 -v $(pwd):/mnt/locust locustio/locust -f /mnt/locust/locustfile.py --host http://192.168.0.190:8080

<!-- - Prometheus: docker run --name prom -p 9090:9090 -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

- Grafana: docker run -d -p 3002:3000 --name=grafana -v $(pwd):/var/lib/grafana grafana/grafana-oss

- rate(process_cpu_seconds_total{job="prometheus"}[5m]) * 100
- process_resident_memory_bytes{job="prometheus"} -->

# Running on EC2 instance

- If the application is running on EC2 instance
- Run each microservice on separate EC2 via - `docker run ...`
- Replace .env file as -
    ```
        VITE_BACKEND_SOCKET=http://BACKEND_EC2_PUBLIC_IP:8080
        VITE_PAYMENT_SOCKET=http://PAYMENT_EC2_PUBLIC_IP:8081
        FRONTEND_SOCKET=http://FRONTEND_EC2_PUBLIC_IP:3000
        # Not to specify database port
        DATABASE_HOST=DATABASE_EC2_PRIVATE_IP
    ```

# Running on Codespaces
- Hardcode server name in nginx.conf (Do not use entrypoint.sh)
- Replace .env file as -
    ```
        FRONTEND_SOCKET=https://expert-broccoli-7x9qxg7v5jv3x644-3000.app.github.dev (replace with codespace url)
        DATABASE_HOST=sneakerdb
    ```

# Running locally
- Must pass NGINX_SERVER in frontend docker build command
- Replace .env file as -
    ```
        VITE_BACKEND_SOCKET=http://localhost:8080
        VITE_PAYMENT_SOCKET=http://localhost:8081
        FRONTEND_SOCKET=http://localhost:3000
        NGINX_SERVER=http://localhost:3000
        DATABASE_HOST=sneakerdb
    ```
