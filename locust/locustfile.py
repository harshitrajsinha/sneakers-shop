import random
from locust import HttpUser, task, between

class Sneakers(HttpUser):
    wait_time = between(1, 3)

    @task(2)
    def get_product_details(self):
        number = random.randint(1, 20)
        self.client.get(f"/api/products/{number}")

    @task(1)
    def get_products(self):
        self.client.get("/api/products")
