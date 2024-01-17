#!/bin/sh

# 配置 SSH 服务
if [ ! -d "/var/run/sshd" ]; then
    mkdir /var/run/sshd
fi
echo 'root:password' | chpasswd
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# 允许任意 IP 访问
echo 'GatewayPorts=yes' >> /etc/ssh/sshd_config

# 启动 SSH 服务
/usr/sbin/sshd

# 生成 SSH 密钥对
ssh-keygen -t ed25519 -f /root/.ssh/id_rsa -N ''

# 添加公钥到 authorized_keys 文件
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# 启动 autossh 以保持隧道连接
# 以下命令假设您已经有了可用的SSH密钥和隧道配置

exec autossh -4 \
    -M 0 \
    -o "ServerAliveInterval 30" \
    -o "ServerAliveCountMax 3" \
    -o "StrictHostKeyChecking=no" \
    -NR 0.0.0.0:2222:github.com:22 root@localhost