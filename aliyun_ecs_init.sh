#!/bin/bash
#set root password
#password=< your password >
echo "$password" | passwd --stdin root >/dev/null 2>&1

#enable password authentication
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl reload sshd

#install docker
curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh | sh
