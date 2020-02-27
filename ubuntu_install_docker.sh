#!/bin/bash

# 参考链接 https://www.bbsmax.com/A/amd0ZoQ6Jg/
# 参考文章 https://www.cnblogs.com/wt7018/p/11880666.html
# 卸载
apt-get remove docker docker-engine docker.io containerd runc

apt-get update
# 安装依赖包
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
# 添加 Docker 的官方 GPG 密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# 验证您现在是否拥有带有指纹的密钥
apt-key fingerprint 0EBFCD88
# 设置稳定版仓库
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-get install docker-ce

# 安装docker－compose
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version


