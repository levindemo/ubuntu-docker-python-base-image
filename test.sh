#!/bin/bash
# 测试基础镜像功能的脚本

# 镜像名称和标签
IMAGE_NAME="ubuntu-docker-python-base"
TAG="latest"

echo "测试Docker客户端..."
docker run --rm $IMAGE_NAME:$TAG docker --version

echo "测试Python版本..."
docker run --rm $IMAGE_NAME:$TAG python --version

echo "测试pip版本..."
docker run --rm $IMAGE_NAME:$TAG pip --version

echo "测试Docker SDK for Python..."
docker run --rm $IMAGE_NAME:$TAG python -c "import docker; print('Docker SDK版本:', docker.__version__)"

# 测试Docker连接（需要宿主机Docker服务运行）
echo "测试Docker连接..."
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock $IMAGE_NAME:$TAG docker ps

echo "所有测试完成"
