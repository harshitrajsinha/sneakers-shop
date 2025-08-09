## Sneakers Shop

* microservice sneakers application
* Frontend: Vue => SPA -> List all sneaker products
* Backend: Golang => Serves REST API for all products, product details
* Payment: Golang => Add entry to database, no real implementation
* Logs & Analytics: Python => Shows most purchased products in last 10 mins (JSON format)
* Database: PostgreSQL => Contains product, logs data

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

- database: docker run --name sneaker-database --network sneakers-shop -p 5432:5432 -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 sneaker-database
- backend: docker run --name sneaker-backend --network sneakers-shop -p 8080:8080 sneaker-backend
- frontend: docker run --name sneaker-frontend -d -p 3000:80 sneaker-frontend
- payment: docker run --name sneaker-payment --network sneakers-shop -p 8081:8081 sneaker-payment
- logs: docker run --name sneaker-logs --network sneakers-shop -p 8082:8082 sneaker-logs
- analytics: docker run --name sneaker-analytics --network sneakers-shop -p 8083:8083 sneaker-analytics

docker exec -it <container-name> psql -U $POSTGRES_USER -d $POSTGRES_DB
