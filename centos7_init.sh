#!/bin/bash
# Filename:   centos7_init.sh
# Date:       2019/01/16
# Author:     root, root@outlook.com
# Version:    2.0
#判断是否为root用户
if [ `whoami` != "root" ];
then
echo " only root can run it"
exit 1
fi
#执行前提示
echo -e "\033[31m 这是centos7系统初始化脚本，将更新系统内核至最新版本，请慎重运行！\033[0m" 
read -s -n1 -p "Press any key to continue or ctrl+C to cancel"
echo "Your inputs: $REPLY"

# 安装阿里yum源、epel源
yum_config() {
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
cd /etc/yum.repos.d/
curl -O http://mirrors.aliyun.com/repo/Centos-7.repo
cd
yum install -y epel-release
}

# 定义安装常用工具的函数
yum_tools() {
yum install –y vim wget bash-completion lsof iotop iostat unzip bzip2 bzip2-devel bridge-utils tree
yum install –y gcc gcc-c++ make cmake autoconf openssl-devel openssl-perl net-tools
source /usr/share/bash-completion/bash_completion
}

#2.定义配置NTP的函数
ntp_config() {
yum install -y chrony
sed -i 's/^server/#&/' /etc/chrony.conf
cat >> /etc/chrony.conf << EOF
server 0.asia.pool.ntp.org iburst
server 1.asia.pool.ntp.org iburst
server 2.asia.pool.ntp.org iburst
server 3.asia.pool.ntp.org iburst
allow all
EOF
systemctl enable chronyd && systemctl restart chronyd
timedatectl set-ntp true
}

#3.定义关闭防火墙和selinux的函数
close_firewalld() {
systemctl stop firewalld && systemctl disable firewalld &> /dev/null 
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config && setenforce 0
}

#5.定义升级最新内核的函数
update_kernel () {
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install -y kernel-ml
grub2-set-default 0
grub2-mkconfig -o /boot/grub2/grub.cfg
}

#执行脚本
main() {
    yum_config;
    ntp_config;
    close_firewalld;
    yum_tools;
    update_kernel;
}
main
