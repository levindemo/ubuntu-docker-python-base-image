#!/bin/bash
set -e

# 启动容器并执行拉取Nginx镜像的操作
echo "启动容器并拉取Nginx镜像..."
docker run --rm -it \
    --privileged \
    -v $(pwd)/pull_nginx.py:/app/pull_nginx.py \
    ubuntu-docker-python-enhanced:latest \
    python3 /app/pull_nginx.py
