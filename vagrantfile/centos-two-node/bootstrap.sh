#!/bin/bash

# Install aliyun repo
echo ">>> Install aliyun repo"
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1

# Install desired packages
echo ">>> Install desired packages"
yum install -y -q vim wget net-tools epel-release >/dev/null 2>&1

# Update the system
# echo ">>> Update the system"
#yum update -y >/dev/null 2>&1

# Config ssh connection
echo ">>> Config ssh connection"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd
echo "root:vagrant" | sudo chpasswd

# Disable SELinux and firewalld
echo ">>> Disable SELinux and firewalld"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
systemctl disable --now firewalld >/dev/null 2>&1