#!/bin/bash
set -e

# 启动Docker daemon
echo "Starting Docker daemon..."
dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 &

# 等待Docker daemon启动
echo "Waiting for Docker daemon to become available..."
while ! docker info > /dev/null 2>&1; do
    sleep 1
done

echo "Docker daemon is running!"

# 如果有传入命令则执行，否则进入交互模式
if [ $# -gt 0 ]; then
    exec "$@"
else
    exec bash
fi
