#!/bin/bash
#install the latest version of docker-ce

bash <(curl -fsSL https://get.docker.com) --mirror Aliyun
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://dockerhub.azk8s.cn"]
}
EOF
systemctl enable --now docker
