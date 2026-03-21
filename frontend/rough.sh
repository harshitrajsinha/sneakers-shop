#!/bin/bash

docker stop sneaker-frontend

docker rm sneaker-frontend

docker build --build-arg VITE_BACKEND_SOCKET=localhost:8080 -t sneaker-frontend .

docker run --name sneaker-frontend -d -e VITE_BACKEND_SOCKET=localhost:8080 -p 3000:80 sneaker-frontend