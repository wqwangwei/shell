#!/bin/bash

set -e
#右键获取下载链接并下载：
downloadurl=https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $downloadurl

#解压源码包
tar zxvf jdk-8u201-linux-x64.tar.gz 
mv jdk-8u201-linux-x64 /usr/local/jdk1.8

#配置环境变量
cat >> /etc/profile << EOF
export JAVA_HOME=/usr/local/jdk1.8
export CLASSPATH=.:${JAVA_HOME}/jre/lib/rt.jar:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar
export PATH=$PATH:${JAVA_HOME}/bin
EOF

#使环境变量生效
source /etc/profile

#确认java版本
java -version