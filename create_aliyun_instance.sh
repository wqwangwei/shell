#!/bin/bash

echo "create vms"

vm_count=3
aliyun ecs RunInstances --Amount $vm_count \
    --ImageId centos_7_8_x64_20G_alibase_20200519.vhd \
    --InstanceType ecs.t5-lc1m2.large \
    --InternetChargeType PayByTraffic \
    --InternetMaxBandwidthIn 50 \
    --InternetMaxBandwidthOut 50 \
    --Password Aliyun#123 \
    --InstanceChargeType PostPaid \
    --SpotStrategy SpotAsPriceGo \
    --RegionId cn-hongkong  \
    --SecurityGroupId sg-j6c8mr535xgiug4hlfpz \
    --VSwitchId vsw-j6cwuu2i3u9nb5d20i4sz \
    --ZoneId cn-hongkong-b > InstanceId.json

echo "sleep 30s waiting for instance ip ready"
sleep 30s

echo "save instance id and ip to instance.list"
rm -rf instance.list
for (( i=0; i < $vm_count; i++ ))
do 
  InstanceId=$(jq -r ".InstanceIdSets.InstanceIdSet[$i]" < InstanceId.json)
  aliyun ecs DescribeInstanceAttribute --InstanceId $InstanceId > info.json
  PrivateIpAddress=$(jq -r ".VpcAttributes.PrivateIpAddress.IpAddress[0]" < info.json)
  PublicIpAddress=$(jq -r ".PublicIpAddress.IpAddress[0]" < info.json)
  echo "################instance$i################" >> instance.list
  echo "InstanceId=$InstanceId" >> instance.list
  echo "PrivateIpAddress=$PrivateIpAddress" >> instance.list
  echo "PublicIpAddress=$PublicIpAddress" >> instance.list
  echo "" >> instance.list
  jq -r ".InstanceIdSets.InstanceIdSet[]" < InstanceId.json >> All_InstanceId.list
done

#run some shell command
#alias remotecmd="aliyun ecs RunCommand --InstanceId.1 $ID0 --RegionId cn-hongkong --Type RunShellScript --CommandContent"
#remotecmd "yum install -y vim wget"

#release all instance
#for i in $(cat All_InstanceId.list); do aliyun ecs DeleteInstances --InstanceId.1 $i --RegionId cn-hongkong --Force true; done
