#!/bin/bash
#set root password
echo "root:123456" | sudo chpasswd >/dev/null 2>&1

#enable password authentication
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl reload sshd

#install docker
#curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh | sh
