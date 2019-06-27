#!/bin/bash  

# create ip_passwd.txt
cat > ip_passwd.txt << EOF
192.168.93.11 123456
192.168.93.12 123456
192.168.93.13 123456
192.168.93.14 123456
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
while read ip password
do
/usr/bin/expect << EOF
spawn ssh-copy-id root@$ip
expect {
        "(yes/no)" {send "yes\r"; exp_continue}
        "*password*" {send "$password\r"}
}
#测试自动登录是否成功
spawn ssh root@$ip
expect { 
         "root@*" { 
           send_user "Auto login $ip successfully!"
           } 
         "assword:" { 
           send_user "failed to login $ip !"
           } 
} 
expect eof
EOF
done < ip_passwd.txt
echo ""
echo -e "\nAll nodes auto ssh login finished,success!"
