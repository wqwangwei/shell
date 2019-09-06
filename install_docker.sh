#!/bin/bash
#install the latest version of docker-ce

curl -fsSL https://get.docker.com -o get-docker.sh 
sh get-docker.sh --mirror Aliyun
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://dockerhub.azk8s.cn"]
}
EOF
systemctl enable --now docker
echo 'install finished,run "docker ps" for test!'
