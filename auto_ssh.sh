#!/bin/bash  
SHELL_PATH=$(dirname $(readlink -f "$0"))
# create ip_passwd.txt
cat > $SHELL_PATH/ip_passwd.txt << EOF
192.168.93.11 123457
192.168.93.12 123456
192.168.93.13 123456
192.168.93.14 123456
192.168.93.15 123456
EOF

# install expect
rpm -qa | grep expect >> /dev/null
if [ $? -eq 0 ];then
  echo "expect already install."
  else
  yum install expect -y
fi

mv -f /root/.ssh/* /tmp/
ssh-keygen -t rsa -N '' -f /root/.ssh/id_rsa -q

#执行deploy对其他节点免密
rm -f $SHELL_PATH/auto_ssh.log
while read ip password
do
/usr/bin/expect << EOF
log_file auto_ssh.log
spawn ssh-copy-id root@$ip
expect {
        "(yes/no)" {send "yes\r"; exp_continue}
        "*password*" {send "$password\r"}
}
#测试自动登录是否成功
spawn ssh root@$ip
expect { 
         "Last login*" { 
           send_user "Auto login $ip successfully!\n"
           } 
         "assword:" { 
           send_user "failed to login $ip\n!"
           } 
} 
expect eof
EOF
done < $SHELL_PATH/ip_passwd.txt

echo ""
echo "Finished!"
echo "The follow login success:"
cat $SHELL_PATH/auto_ssh.log | grep successfully

echo ""
echo "The follow login failed:"
cat $SHELL_PATH/auto_ssh.log | grep -Ei "failed|ERROR"
