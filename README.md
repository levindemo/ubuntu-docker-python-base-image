# Ubuntu-Docker-Python 基础镜像

这是一个基于Ubuntu 22.04的基础镜像，预装了Docker客户端和Python 3.10环境，适用于开发自动化镜像构建Agent。

## 镜像特点

- 基于Ubuntu 22.04 LTS
- 包含Docker客户端，可执行Docker相关命令
- 预装Python 3.10及pip包管理工具
- 已安装Docker SDK for Python (docker库)
- 配置了必要的系统依赖

## 构建镜像

运行构建脚本构建镜像：
chmod +x build.sh
./build.sh
## 测试镜像

构建完成后，可以运行测试脚本验证镜像功能：
chmod +x test.sh
./test.sh
## 使用镜像

直接运行容器：
docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    ubuntu-docker-python-base:latest
> 注意：挂载`/var/run/docker.sock`可以让容器内的Docker客户端访问宿主机的Docker守护进程

## 示例代码

`example_usage.py`文件展示了如何使用Docker SDK for Python操作Docker：
# 在容器内运行示例代码
docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $(pwd)/example_usage.py:/app/example_usage.py \
    ubuntu-docker-python-base:latest \
    python example_usage.py
## 后续应用规划

该基础镜像可用于开发自动化镜像构建Agent，实现以下功能：

1. 从代码仓库拉取源代码
2. 根据项目中的Dockerfile自动构建镜像
3. 将构建好的镜像推送到镜像仓库
4. 实现构建过程的日志记录和监控
5. 集成CI/CD流程，实现自动化部署