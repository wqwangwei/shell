#!/bin/bash

#install tools
yum install -y vim wget

#config aliyun yum repo
#https://opsx.alibaba.com/mirror
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

#disable firewall
systemctl stop firewalld && systemctl disable firewalld &> /dev/null 
sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /etc/selinux/config && setenforce 0

#disable NetworkManager
systemctl stop NetworkManager && systemctl disable NetworkManager
