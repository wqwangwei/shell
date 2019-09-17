### Install latest version of dokcer-ce
```
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh | sh
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/install_docker_version.sh | sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh)"

sh -c "$(wget -O- https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh)"

curl -Lo install.sh https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh
sh install.sh
```


## Install docker-ce
```
curl -O https://raw.githubusercontent.com/willzhang/shell/master/shadowsocks/docker_run_ssr.sh && bash docker_run_ssr.sh
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/git-install.sh | sh
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/pull_k8s_images.sh | sh
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/pull-aliyun-images.sh | sh
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/push-aliyun-images.sh | sh
```

```
wget https://raw.githubusercontent.com/willzhang/shell/master/auto_ssh.sh 
wget https://raw.githubusercontent.com/willzhang/shell/master/push_images.sh
```

## 常用命令
```
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install -y docker-ce 
systemctl start docker && systemctl enable docker

setenforce 0
sed -i 's/enforcing/disabled/g' /etc/selinux/config
systemctl stop firewalld.service && systemctl disable firewalld.service
```

```
SHELL_NAME=upgrade_centos7_kernel.sh
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/$SHELL_NAME | sh
```
