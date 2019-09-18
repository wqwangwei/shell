#!/bin/bash

# Update the system
echo "[TASK 1] Updating the system"
#yum update -y >/dev/null 2>&1

# Install desired packages
echo "[TASK 2] Installing desired packages"
yum install -y -q vim wget net-tools redhat-lsb-core epel-release >/dev/null 2>&1

# Install aliyun repo
echo "[TASK 3] Installing desired packages"
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# Enable password authentication
echo "[TASK 4] Enabling password authentication in sshd config"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Disable SELinux
echo "[TASK 5] Disable SELinux"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

# Disable and stop firewalld
echo "[TASK 6] Disable and stop firewalld"
systemctl disable --now firewalld >/dev/null 2>&1

# Set Root password
echo "[TASK 7] Set root password"
echo "root:123456" | sudo chpasswd >/dev/null 2>&1

# Update hosts file
echo "[TASK 8] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.10 server.example.com server
172.42.42.20 client.example.com client
EOF
