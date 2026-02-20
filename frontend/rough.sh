#!/bin/bash

docker stop sneaker-frontend

docker rm sneaker-frontend

docker build --build-arg VITE_SERVER_IP=localhost -t sneaker-frontend .

docker run --name sneaker-frontend -d -e VITE_SERVER_IP=localhost -p 3000:80 sneaker-frontend