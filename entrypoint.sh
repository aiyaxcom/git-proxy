#!/bin/sh

# 添加 VPN 服务器的主机密钥到 known_hosts 文件
ssh-keyscan -H ${SSH_HOST} >> /root/.ssh/known_hosts

# 打印 SSH_HOST 的值
echo "SSH_HOST: ${SSH_HOST}"

# 启动 autossh 以保持隧道连接
# 以下命令假设您已经有了可用的SSH密钥和隧道配置
# 请根据实际情况替换 SSH_USER, SSH_HOST, SSH_PORT, LOCAL_PORT, REMOTE_HOST 和 REMOTE_PORT

exec autossh \
    -M 0 \
    -o "ServerAliveInterval 30" \
    -o "ServerAliveCountMax 3" \
    -p "${SSH_PORT}" \
    -l "${SSH_USER}" \
    -L "${LOCAL_PORT}:${REMOTE_HOST}:${REMOTE_PORT}" \
    "${SSH_HOST}" -N