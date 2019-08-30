##### 需求描述

监控/data目录使用情况，大于85%则删除该目录下20天以前的数据

##### 脚本示例

mkdir -p /data/disk_clean/

touch /data/disk_clean/disk_clean.sh

chmod +x  /data/disk_clean/disk_clean.sh

```bash
#!/bin/bash
exec &>/data/disk_clean/clean.log
clean_dir=/data/test/
use_limit=85
use_radio=`df -h | grep -w "/" | awk '{print $5}' | cut -f 1 -d "%"`
if [ $use_radio -gt $use_limit ]
then
  echo -e "before_clean: \n$(df -h | grep -w "/")"
  find $clean_dir -mtime +20 -type f -name "*.txt" | xargs rm -rf
  echo -e "after_clean: \n$(df -h | grep -w "/")"
fi
```

##### 定时任务：

每分钟执行一次

```bash
[root@localhost test]# crontab -e
23 23 * * 5 /data/test/test.sh

[root@localhost test]# crontab -l
*/1 * * * * /data/test/test.sh
```

测试方法：

```bash
fallocate -l 20G bigfile
touch -d "7/1/2019" test.txt
```



