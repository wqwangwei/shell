#!/bin/bash
#########################################################################
#function  yum install MYSQL
#Author    admin
#Mail      admin@mail.com
#########################################################################
#安装mysql官方yum源
rpm -Uvh https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
#安装mysql
yum -y install mysql-community-server
#启动服务并设为开机启动
systemctl start mysqld && systemctl enable mysqld
