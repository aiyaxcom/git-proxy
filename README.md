# git-proxy
这两天发现git无法通过ssh key操作remote Github仓库，有些许不便，所以在VPN服务器部署git-proxy项目以支持git ssh的转发

## docker-compose启动
```
version: '3.8'

services:
  autossh:
    image: aiyax/git-proxy:latest
    volumes:
      - ./id_rsa:/root/.ssh/id_rsa:ro # 将您的私钥文件挂载到容器中
    environment:
      - SSH_USER=你的用户名
      - SSH_HOST=vpn服务器地址
      - SSH_PORT=vpn端口号
      - LOCAL_PORT=本地端口
      - REMOTE_HOST=github.com
      - REMOTE_PORT=22
    restart: always # 确保在退出时重新启动
```
