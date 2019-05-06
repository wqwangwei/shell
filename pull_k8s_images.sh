cat > pull_dockerhub.sh << EOF
#!/bin/bash

##########################################################
cat > img-list.txt << EOF
gcr.io/heptio-images/sonobuoy:v0.13
gcr.io/heptio-images/kube-conformance:latest
gcr.io/heptio-images/scanner-forwarder:v0.0.4
gcr.io/heptio-images/namespace-deleter:v0.0.1
EOF
##########################################################

DOCKER_HUB=willdockerhub
for image in $(cat img-list.txt)
do
	imagename=$(echo $image | awk -F '/' '{print $NF}')
	docker pull $DOCKER_HUB/$imagename
	docker tag $DOCKER_HUB/$imagename $image
	docker rmi $DOCKER_HUB/$imagename
done
EOF
sh pull_dockerhub.sh
