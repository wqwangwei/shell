#!/bin/bash

for imagepath in $(cat $HOME/imagepath.txt)
do
imagename=$(echo $imagepath | awk -F '/' '{print $NF}')
docker pull registry.cn-hangzhou.aliyuncs.com/aliwill/$imagename
docker tag registry.cn-hangzhou.aliyuncs.com/aliwill/$imagename $imagepath
docker rmi registry.cn-hangzhou.aliyuncs.com/aliwill/$imagename
done 