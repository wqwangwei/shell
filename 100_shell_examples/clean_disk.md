##### 需求描述

监控磁盘使用情况，大于90%则删除20天以前的数据

##### 脚本示例

```bash
#!/bin/bash
use_limit=90
use_radio=`df -h | grep /dev/sda1 | awk '{print $5}' | cut -f 1 -d "%"`
df_info=/data/test/df_info.log
if [ $use_radio -gt $use_limit ]
then
  df -h > $df_info
  find /data/test/ -mtime +20 -type d -name "*.txt" | xargs rm -rf
fi
```

##### 定时任务：

```bash
[root@localhost test]# crontab -e
10 0 * * * /data/test/test.sh

[root@localhost test]# crontab -l
10 0 * * * /data/test/test.sh
```

##### 定时任务：

```bash
[root@localhost test]# crontab -e
* * * * * /data/test/test.sh

[root@localhost test]# crontab -l
10 0 * * * /data/test/test.sh
```



```bash
touch -d  "7/1/2019" test.txt 
dd if=/dev/zero of=test.txt count=10 bs=512M
```



