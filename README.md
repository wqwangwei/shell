##Install docker-ce
```
#Install docker-ce
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh | sh
```

##Install git
```
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/git-install.sh | sh
```

##Pull k8s images
```
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/pull_k8s_images.sh | sh
```

##pull-aliyun-images
```
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/pull-aliyun-images.sh | sh
```

##push-aliyun-images
```
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/push-aliyun-images.sh | sh
```

##常用命令
```
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install -y docker-ce 
systemctl start docker && systemctl enable docker

setenforce 0
sed -i 's/enforcing/disabled/g' /etc/selinux/config
systemctl stop firewalld.service && systemctl disable firewalld.service
```
