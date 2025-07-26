"""
Docker SDK for Python使用示例
展示如何通过Python代码操作Docker客户端
"""
import docker
from docker.errors import DockerException

def test_docker_connection():
    """测试与Docker守护进程的连接"""
    try:
        client = docker.from_env()
        # 检查连接
        client.ping()
        print("成功连接到Docker守护进程")
        return client
    except DockerException as e:
        print(f"无法连接到Docker守护进程: {e}")
        return None

def get_docker_info(client):
    """获取Docker系统信息"""
    if not client:
        return
    
    try:
        info = client.info()
        print("\nDocker系统信息:")
        print(f" Docker版本: {info['ServerVersion']}")
        print(f" 容器总数: {info['Containers']}")
        print(f" 镜像总数: {info['Images']}")
        print(f" 操作系统: {info['OperatingSystem']}")
    except DockerException as e:
        print(f"获取Docker信息失败: {e}")

def list_images(client):
    """列出所有本地镜像"""
    if not client:
        return
    
    try:
        images = client.images.list()
        print("\n本地镜像列表:")
        for img in images:
            tags = img.tags[0] if img.tags else "无标签"
            print(f" - {tags} (ID: {img.id[:12]})")
    except DockerException as e:
        print(f"列出镜像失败: {e}")

def main():
    """主函数"""
    print("=== Docker SDK for Python 使用示例 ===")
    client = test_docker_connection()
    get_docker_info(client)
    list_images(client)
    print("\n=== 示例结束 ===")

if __name__ == "__main__":
    main()
