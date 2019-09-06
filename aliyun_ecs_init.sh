#!/bin/bash
#password=<>
(echo "$password";sleep 1;echo "$password") | sudo passwd root > /dev/null
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

curl -sSL https://raw.githubusercontent.com/willzhang/shell/master/install_docker.sh | sh