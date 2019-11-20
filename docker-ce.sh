#!/bin/bash

#install latest version of docker-ce
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

#Configuration Mirror Acceleration
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://dockerhub.azk8s.cn"]
}
EOF

#start and enable docker service
systemctl daemon-reload && systemctl enable --now docker
