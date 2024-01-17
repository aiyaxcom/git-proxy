#!/bin/sh

# 配置 SSH 服务
mkdir /var/run/sshd
echo 'root:password' | chpasswd
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 允许任意 IP 访问
echo 'GatewayPorts=yes' >> /etc/ssh/sshd_config

# 启动 SSH 服务
/usr/sbin/sshd

# 添加主机密钥到 known_hosts 文件
#ssh-keyscan -H "github.com" >> /root/.ssh/known_hosts

# 启动 autossh 以保持隧道连接
# 以下命令假设您已经有了可用的SSH密钥和隧道配置

exec autossh -4 \
    -M 0 \
    -o "ServerAliveInterval 30" \
    -o "ServerAliveCountMax 3" \
    -NR 0.0.0.0:2222:github.com:22 root@localhost