#!/bin/bash

CONTAINERS=$(docker ps -aq)

for CONTAINER in "${CONTAINERS}"; do
	docker rm ${CONTAINER}
done

IMAGES=$(docker images -q)

for IMAGE in "${IMAGES}"; do
	docker rmi ${IMAGE}
done	
