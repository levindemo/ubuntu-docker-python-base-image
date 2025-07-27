#!/bin/env bash
set -x

export HTTP_PROXY='http://127.0.0.1:1080'
export HTTPS_PROXY='http://127.0.0.1:1080'
export NO_PROXY='localhost,127.0.0.1'
# 构建基础镜像的脚本

# 镜像名称和标签
IMAGE_NAME="ubuntu-docker-python-base-v2"
TAG="latest"

# 构建镜像
echo "开始构建基础镜像: $IMAGE_NAME:$TAG"
docker build -t $IMAGE_NAME:$TAG -f DockerfileV311 .

# 推送镜像
echo "开始推送镜像: $IMAGE_NAME:$TAG"
docker push $IMAGE_NAME:$TAG

# 检查构建是否成功
if [ $? -eq 0 ]; then
    echo "镜像构建成功: $IMAGE_NAME:$TAG"
    
    # 显示构建的镜像信息
    echo "镜像信息:"
    docker images $IMAGE_NAME:$TAG
else
    echo "镜像构建失败"
    exit 1
fi
