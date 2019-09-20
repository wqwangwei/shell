#!/bin/bash
SRC_GROUP_NAME=test17
NEW_GROUP_NAME=test16
NEW_GROUP_ID=20

SCRIPT_PATH=$(dirname $(readlink -f $0))
PROJECT_LIST=$SCRIPT_PATH/project.list
ACCESS_TOKEN=xxxxxx
GITLAB_URL=http://10.0.99.191
SSH_URL=git@10.0.99.191

get_name() {
curl -s --header "PRIVATE-TOKEN: ${ACCESS_TOKEN}"  ${GITLAB_URL}/api/v4/groups/${SRC_GROUP_NAME}/projects | jq -r '.[] | .name' > ${PROJECT_LIST}
}

git_clone() {
mkdir ${SCRIPT_PATH}/${SRC_GROUP_NAME} && cd ${SCRIPT_PATH}/${SRC_GROUP_NAME}
for i in $(cat ${PROJECT_LIST})
do
  git clone ${SSH_URL}:${SRC_GROUP_NAME}/${i}.git
done
}

create_project() {
for i in $(cat ${PROJECT_LIST})
do
  curl --request POST --header "PRIVATE-TOKEN: ${ACCESS_TOKEN}"  --data "name=${i}&namespace_id=${NEW_GROUP_ID}" ${GITLAB_URL}/api/v4/projects
done
}

push_newgroup() {
for i in $(cat ${PROJECT_LIST})
do
  cd ${i} && rm -rf .git
  git init
  git remote add origin ${SSH_URL}:${NEW_GROUP_NAME}/${i}.git
  git add .
  git commit -m "Initial commit"
  git push -u origin master
  cd ..
done
}

if [ -d ${SCRIPT_PATH}/${SRC_GROUP_NAME} ]
then
  echo rm ${SCRIPT_PATH}/${SRC_GROUP_NAME}, then retry!
  exit 0
fi
get_name
git_clone
create_project
push_newgroup