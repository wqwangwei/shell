#!/bin/bash
script_dir=$(dirname $(readlink -f $0 ))

image_list=$(cat $script_dir/image_list.txt)

#destination registry to push
registry=192.168.93.40/sonobuoy

pull_image(){
for image in $image_list
do
  docker pull $image
done
}

save_image(){
if [ ! -d $script_dir/images ];then mkdir $script_dir/images;fi

save_dir=$script_dir/images

for image in $image_list
do
  image_name=${image##*/}
  docker save $image -o $save_dir/${image_name}.tar
done
}

load_image(){
save_dir=$script_dir/images

for image in $image_list
do
  image_name=${image##*/}
  docker load -i $save_dir/${image_name}.tar
done
}

retag_image(){
for image in $image_list
do

  image_name=${image##*/}
  docker tag $image $registry/$image_name
done
}

push_image(){
for imagepath in $image_list
do
  image_name=${image##*/}
  docker push $registry/$image_name
done
}

pull_image
save_image
load_image
retag_image
push_image
