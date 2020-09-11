#!/bin/bash

path=${PWD}

if [[ ! -d testfile ]];then
  mkdir testfile
fi

rm -rf testfile/*
rm -rf ${path}/new.md
cp test2.txt.bak test2.txt

IFS=''
while read line
do
  if [[ ! $line =~ ^[[:space:]].* ]]
  then
    group=testfile/$line
    touch $group
  else
    echo $line >> $group
  fi
done < test2.txt

ls ${path}/testfile/ > 1.list

unset IFS
for file in $(cat 1.list)
do
  echo "* [${file}](${file}/README.md)" >> ${path}/new.md
  for file1 in $(cat ${path}/testfile/${file})
  do
    echo "  * [${file1}](${file}/${file1}.md)" >> ${path}/new.md
  done
done
