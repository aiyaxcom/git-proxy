# git-proxy
这两天发现git无法通过ssh key操作remote Github仓库，有些许不便，所以在VPN服务器部署git-proxy项目以支持git ssh的转发

## Github官方解决方案
项目调试到一半，发现Github官方已经提供了解决方案。
官方解决方案[Using SSH over the HTTPS port](https://docs.github.com/en/github/authenticating-to-github/using-ssh-over-the-https-port)中的第二种方案和本项目的方案一致，都是通过修改`~/.ssh/config`文件来实现SSH请求的转发。

官方的`~/.ssh/config`配置如下：
```
Host github.com
    Hostname ssh.github.com
    Port 443
    User git
```

## 自定义解决方案

1. 在可以访问github.com的服务器上部署git-proxy项目
```
version: '3.8'

services:
  autossh:
    image: aiyax/git-proxy:v1.0.0
    volumes:
      - /etc/passwd:/etc/passwd:ro
      - /etc/group:/etc/group:ro
    ports:
      - 2222:2222
    restart: always
```

2. 在本地`~/.ssh/config`文件中添加如下配置
```
Host github.com
    Hostname <your server ip or hostname>
    Port 2222
    User git
```

## 支持

关注微信公众号"e界书生"，获取更多有趣分享！

![e界书生](https://aiyax.com/images/ejieshusheng.jpg)
