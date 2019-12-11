#定义主机IP、用户名及密码
cat > hosts.list << EOF
#!/bin/bash
192.168.93.31 root 123456
192.168.93.32 root 123456
EOF

#本机对所有节点ssh免密
cat > auto_ssh.sh << EOF
#!/bin/bash
rpm -qa | grep sshpass >> /dev/null; if [ $? -ne 0 ]; then yum install -y sshpass; fi
if [ ! -f "/root/.ssh/id_rsa.pub" ]; then echo -e 'y\n' | ssh-keygen -q -t rsa -b 2048 -N "" -f /root/.ssh/id_rsa; fi
while read IP USER PASS
do
  echo ">>> ${IP}"
  sshpass -p $PASS ssh-copy-id -o StrictHostKeyChecking=no $USER@$IP
done < hosts.list
EOF

sh auto_ssh.sh
