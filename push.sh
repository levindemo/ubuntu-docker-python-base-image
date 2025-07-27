#!/bin/env bash
set -x

export HTTP_PROXY='http://127.0.0.1:1080'
export HTTPS_PROXY='http://127.0.0.1:1080'
export NO_PROXY='localhost,127.0.0.1'
# 构建基础镜像的脚本

# 镜像名称和标签
IMAGE_NAME="ubuntu-docker-python-base"
TAG="latest"

# 构建镜像
echo "开始构建基础镜像: $IMAGE_NAME:$TAG"
#docker build -t $IMAGE_NAME:$TAG -f DockerfileV311 .

#load the org prefix from env
ORG_PREFIX=${DOCKER_HUB_ORG_PREFIX:-}

echo "org prefix: $ORG_PREFIX"

#check if org prefix is empty
if [ -z "$ORG_PREFIX" ]; then
    echo "org prefix is empty, please set DOCKER_HUB_ORG_PREFIX env"
    exit 1
fi

# tag 镜像
NEW_TAG="v39"
echo "开始tag镜像: ${ORG_PREFIX}$IMAGE_NAME:$NEW_TAG"
docker tag $IMAGE_NAME:$TAG ${ORG_PREFIX}$IMAGE_NAME:$NEW_TAG

# Authenticating with existing credentials...
docker login
# 推送镜像
echo "开始推送镜像: ${ORG_PREFIX}$IMAGE_NAME:$NEW_TAG"
docker push ${ORG_PREFIX}$IMAGE_NAME:$NEW_TAG

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
