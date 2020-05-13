#!/bin/bash
# sh aliyun_sealos_k8s.sh 1.18.2 https://sealyun.oss-cn-beijing.aliyuncs.com/9a8299ea8016abe32e1564a44d5162e4-1.18.2/kube1.18.2.tar.gz

echo "create 4 vms"
aliyun ecs RunInstances --Amount 4 \
    --ImageId centos_7_7_x64_20G_alibase_20191225.vhd \
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
ID0=$(jq -r ".InstanceIdSets.InstanceIdSet[0]" < InstanceId.json)
ID1=$(jq -r ".InstanceIdSets.InstanceIdSet[1]" < InstanceId.json)
ID2=$(jq -r ".InstanceIdSets.InstanceIdSet[2]" < InstanceId.json)
ID3=$(jq -r ".InstanceIdSets.InstanceIdSet[3]" < InstanceId.json)

echo "sleep 40s wait for IP and FIP"
sleep 40 # wait for IP

aliyun ecs DescribeInstanceAttribute --InstanceId $ID0 > info.json
master0=$(jq -r ".VpcAttributes.PrivateIpAddress.IpAddress[0]" < info.json)
master0FIP=$(jq -r ".PublicIpAddress.IpAddress[0]" < info.json)

aliyun ecs DescribeInstanceAttribute --InstanceId $ID1 > info.json
master1=$(jq -r ".VpcAttributes.PrivateIpAddress.IpAddress[0]" < info.json)

aliyun ecs DescribeInstanceAttribute --InstanceId $ID2 > info.json
master2=$(jq -r ".VpcAttributes.PrivateIpAddress.IpAddress[0]" < info.json)

aliyun ecs DescribeInstanceAttribute --InstanceId $ID3 > info.json
node=$(jq -r ".VpcAttributes.PrivateIpAddress.IpAddress[0]" < info.json)

echo "all nodes IP: $master0 $master1 $master2 $node"

echo "wait for sshd start"
sleep 100 # wait for sshd

# $2 is sealos clientip
alias remotecmd="aliyun ecs RunCommand --InstanceId.1 $ID0 --RegionId cn-hongkong --Type RunShellScript --CommandContent"

echo "install sealos command"
remotecmd "wget https://github.com/fanux/sealos/releases/download/v3.3.3/sealos && chmod +x sealos && mv sealos /usr/bin"

echo "sleep 100s wait for sealos command"
sleep 100
version=$1
pkgurl=$2

echo "run sealos init command"
remotecmd "sealos init --master $master0 --master $master1 --master $master2 --node $node --passwd Aliyun#123 --version v$version --pkg-url $pkgurl | tee sealos_init.log"

echo "wait for everything ok"
sleep 40
remotecmd "kubectl get node && kubectl get pod --all-namespaces && kubectl get cs"
#./sshcmd --passwd Aliyun#123 --host $master0FIP --cmd "kubectl get node && kubectl get pod --all-namespaces && kubectl get cs"

release_instance() {
  echo "release instance"
  sleep 20
  aliyun ecs DeleteInstances --InstanceId.1 $ID0 --RegionId cn-hongkong --Force true
  aliyun ecs DeleteInstances --InstanceId.1 $ID1 --RegionId cn-hongkong --Force true
  aliyun ecs DeleteInstances --InstanceId.1 $ID2 --RegionId cn-hongkong --Force true
  aliyun ecs DeleteInstances --InstanceId.1 $ID3 --RegionId cn-hongkong --Force true
}

#release_instance()
