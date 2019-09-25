#!/bin/bash
#导入公钥，Import the public key:
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

#安装ELRepo存储库：
yum install -y https://www.elrepo.org/elrepo-release-8.0-2.el8.elrepo.noarch.rpm
#yum install -y https://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm 

#指定ELRepo存储库安装最新的稳定内核
yum --enablerepo=elrepo-kernel install -y kernel-ml

#修改 GRUB 配置：
grub2-set-default 0

#重新创建内核配置.
grub2-mkconfig -o /boot/grub2/grub.cfg

# 删除旧版本工具包
rpm -qa | grep kernel-tools | xargs yum remove -y
# 安装新版本工具包
yum --disablerepo=\* --enablerepo=elrepo-kernel install -y kernel-ml-{tools,headers,devel}.x86_64

#重启系统验证
reboot
# uname -sr

#删除旧版本内核
# rpm -qa | grep kernel-3.10 | xargs yum remove -y
