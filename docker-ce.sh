#!/bin/bash

#install latest version of docker-ce
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

#Configuration Mirror Acceleration
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://7bafc985f90c43b887a96c2b846cf984.mirror.swr.myhuaweicloud.com"]
}
EOF

#start and enable docker service
systemctl daemon-reload && systemctl enable --now docker
