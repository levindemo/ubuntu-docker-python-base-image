#!/bin/env bash
set -x

IMAGE_NAME="ubuntu-docker-python-base-v2"
TAG="v311"
TAG="latest"

#docker run with cmd as python3 -m http.server 8080 and container name is 'ubuntu-docker-py311'
#stop if any existing docker with same name
docker stop ubuntu-docker-py311
docker rm ubuntu-docker-py311
#docker run -it --rm -p 8080:8080 --name ubuntu-docker-py311 $IMAGE_NAME:$TAG bash -c "python3 -m http.server 8080"
docker run --rm -it --privileged  -p 8080:8080 --name ubuntu-docker-py311 $IMAGE_NAME:$TAG bash -c "python3 -m http.server 8080"

#docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
# -it  -p 8080:8080 --name ubuntu-docker-py311 $IMAGE_NAME:$TAG bash -c "python3 -m http.server 8080"