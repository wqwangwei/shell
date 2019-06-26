#!/bin/bash
#destination registry you want push
registry=registry.cn-hangzhou.aliyuncs.com/aliwill/

#perpare imagepath.txt at current dir
for imagepath in $(cat $imagepath.txt)
do
imagename=$(echo $imagepath | awk -F '/' '{print $NF}')
docker pull $imagepath
docker tag $imagepath $registry$imagename
docker push $registry$imagename
docker rmi $imagepath
done
