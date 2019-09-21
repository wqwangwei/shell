#!/bin/bash

# Install aliyun repo
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# Install desired packages
yum install -y -q vim wget net-tools epel-release >/dev/null 2>&1

# Update the system
#yum update -y >/dev/null 2>&1

# Enable password authentication
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Disable SELinux
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Disable and stop firewalld
systemctl disable --now firewalld >/dev/null 2>&1

# Set Root password
echo "root:vagrant" | sudo chpasswd >/dev/null 2>&1