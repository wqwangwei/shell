#!/bin/sh
#传递ImagePath-ImageName.txt中的两列参数到for循环中
#其中ImagePath为第一列参数，ImageName为第二列参数

while read ImagePath ImageName
do
	docker pull $ImagePath
	docker tag $ImagePath registry.cn-hangzhou.aliyuncs.com/aliwill/$ImageName
	docker push registry.cn-hangzhou.aliyuncs.com/aliwill/$ImageName
done </root/ImagePath-ImageName.txt