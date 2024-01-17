# git-proxy
这两天发现git无法通过ssh key操作remote Github仓库，有些许不便，所以在VPN服务器部署git-proxy项目以支持git ssh的转发

## docker-compose启动
```
version: '3.8'

services:
  autossh:
    image: aiyax/git-proxy:latest
    volumes:
      - /root/.ssh/id_ed25519:/root/.ssh/id_rsa:ro # 将您的私钥文件挂载到容器中
      - /etc/passwd:/etc/passwd:ro # 将宿主机的用户信息挂载到容器中
      - /etc/group:/etc/group:ro # 将宿主机的用户组信息挂载到容器中
    ports:
      - 2222:2222
    restart: always # 确保在退出时重新启动
```
