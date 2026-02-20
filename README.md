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

- network: docker network create sneakers-shop
- database: docker build -t sneaker-database .
- backend: docker build -t sneaker-backend .
- frontend: docker build -t sneaker-frontend .
- payment: docker build -t sneaker-payment .
- logs: docker build -t sneaker-logs .
- analytics: docker build -t sneaker-analytics .

### Container Run

- database: docker run --name sneaker-database --network sneakers-shop -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 sneaker-database
- backend: docker run --name sneaker-backend --network sneakers-shop -p 8080:8080 sneaker-backend
- backend: docker run --name sneaker-backend --cpus="1.0" -m 100m --network sneakers-shop -p 8080:8080 sneaker-backend
- frontend: docker run --name sneaker-frontend -d -p 3000:80 sneaker-frontend
- payment: docker run --name sneaker-payment --network sneakers-shop -p 8081:8081 sneaker-payment
- logs: docker run --name sneaker-logs --network sneakers-shop -p 8082:8082 sneaker-logs
- analytics: docker run --name sneaker-analytics --network sneakers-shop -p 8083:8083 sneaker-analytics
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