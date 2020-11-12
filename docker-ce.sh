#!/bin/bash

#install latest version of docker-ce
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
sed -e 's/7/8/g' /etc/yum.repos.d/docker-ce.repo
yum makecache fast
#Configuration Mirror Acceleration
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://mupbrrgf.mirror.aliyuncs.com"]
}
EOF

#start and enable docker service
systemctl daemon-reload && systemctl enable --now docker
