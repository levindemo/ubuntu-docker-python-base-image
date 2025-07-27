# 基于Ubuntu的基础镜像，包含Docker客户端和Python 3.9
FROM ubuntu:22.04

#add port as argument
ARG PORT=8080
# 避免交互模式下的配置提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置时区为UTC，可根据需要修改
ENV TZ=UTC

# 更新系统并安装必要依赖
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装Docker客户端
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# 安装Python 3.9及相关工具

RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update

RUN apt-get install -y \
    python3.9 \
    python3.9-dev \
    python3.9-distutils \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3.9 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip || echo "ln -s /usr/bin/pip3 /usr/bin/pip failed"

# 升级pip并安装Docker SDK for Python
RUN pip install --upgrade pip \
    && pip install docker

# 验证安装
RUN docker --version && python --version && pip --version

# 设置工作目录
WORKDIR /app

# 容器启动时默认执行bash
CMD ["/bin/bash", "-c", "python3 -m http.server $PORT"]
