#!/bin/bash

# Build latest
echo "Building sprucenews:dev"
docker build --quiet --tag sprucenews:dev .

# check for dev container running
if [[  $(docker ps -q --filter ancestor=sprucenews:dev) ]]; then
	echo "Container running, stoping..."
	docker stop $(docker ps -q --filter ancestor=sprucenews:dev)
fi

# Start container with volume map
PRESENT_DIR=$(pwd -W)
echo "Starting sprucenews:dev"
docker run -d -v "$PRESENT_DIR/html:/usr/share/nginx/html" --publish 8080:8080 sprucenews:dev