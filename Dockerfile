# 使用 Ubuntu 官方的最小化基础镜像
FROM ubuntu:22.04

# 避免在构建过程中出现交互式提示
ARG DEBIAN_FRONTEND=noninteractive

# 更新软件包列表，安装 autossh，并清理缓存以减小镜像体积
RUN apt-get update \
    && apt-get install -y --no-install-recommends autossh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置环境变量，这些可以通过docker-compose.yml文件或在运行容器时进行覆盖
ENV AUTOSSH_GATETIME=30 \
    AUTOSSH_LOGFILE=/dev/stdout \
    AUTOSSH_POLL=10 \
    AUTOSSH_PORT=0 \
    AUTOSSH_DEBUG=1

# 将启动脚本添加到容器
COPY entrypoint.sh /entrypoint.sh

# 使启动脚本可执行
RUN chmod +x /entrypoint.sh

# 设置容器的默认命令为启动脚本
ENTRYPOINT ["/entrypoint.sh"]