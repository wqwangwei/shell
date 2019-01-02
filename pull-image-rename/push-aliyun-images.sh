#!/bin/bash

for ImagePath in $(cat /root/ImagePath.txt)
do
ImageName=$(echo $ImagePath | awk -F '/' '{print $NF}')
docker pull $ImagePath
docker tag $ImagePath registry.cn-hangzhou.aliyuncs.com/aliwill/$ImageName
docker push registry.cn-hangzhou.aliyuncs.com/aliwill/$ImageName
done
