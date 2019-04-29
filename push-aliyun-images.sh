#!/bin/bash
#perpare imagepath.txt and registry

cmd_path=$(cd "$(dirname "$0")";pwd)
imagepath.txt=$cmd_path/imagepath.txt

registry=registry.cn-hangzhou.aliyuncs.com/aliwill/
registry=100.75.30.60

for imagepath in $(cat $imagepath.txt)
do
imagename=$(echo $imagepath | awk -F '/' '{print $NF}')
docker pull $imagepath
docker tag $imagepath $registry$imagename
docker push $registry$imagename
docker rmi $imagepath
done