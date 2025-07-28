import docker
import time


def pull_nginx_image():
    try:
        # 连接到本地Docker daemon
        client = docker.from_env()

        print("正在检查Nginx镜像是否存在...")
        # 检查镜像是否已存在
        images = client.images.list(name="nginx")
        if images:
            print("Nginx镜像已存在")
            return

        print("开始拉取Nginx镜像...")
        # 拉取最新版Nginx镜像
        image = client.images.pull("nginx:latest")

        print(f"成功拉取Nginx镜像: {image.tags[0]}")

        # 显示镜像信息
        print("镜像详细信息:")
        print(f"ID: {image.id}")
        print(f"标签: {image.tags}")
        print(f"大小: {image.attrs['Size']} bytes")

    except Exception as e:
        print(f"操作失败: {str(e)}")


if __name__ == "__main__":
    pull_nginx_image()
