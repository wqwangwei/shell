#!/bin/bash

# Update the system
echo "[TASK 1] Updating the system"
#apt-get update -y >/dev/null 2>&1

# Install desired packages
echo "[TASK 2] Installing desired packages"
#apt-get install -y -q xxx >/dev/null 2>&1

# Install aliyun repo
echo "[TASK 3] Install aliyun repo"
cp /etc/apt/sources.list{,.bak}
sed -i 's#http://archive.ubuntu.com/#http://mirrors.aliyun.com/#g' /etc/apt/sources.list

# Enable password authentication
echo "[TASK 4] Enabling password authentication in sshd config"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "[TASK 5] Set root password"
echo "root:vagrant" | sudo chpasswd >/dev/null 2>&1
