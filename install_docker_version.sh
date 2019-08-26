#!/bin/bash

#install docker-ce
set -e

#指定安装的docker版本
#yum list docker-ce --showduplicates | sort -r
docker_version=docker-ce

#安装依赖软件包
yum install -y yum-utils \
	device-mapper-persistent-data \
	lvm2 \
	git

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install -y $docker_version

mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF

systemctl enable --now docker
