#!/bin/bash

#install tools
yum install -y vim wget
#config aliyun yum repo
cd /etc/yum.repos.d/
mkdir repo_bak
mv *.repo repo_bak/
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#disable firewall
systemctl stop firewalld && systemctl disable firewalld &> /dev/null 
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config && setenforce 0