## Backup harbor registry images 

Backup harbor registry images to local server when you do a reinstall.

修改参数:
```
harbor_endpoint=localhost 
harbor_username=admin 
harbor_password=Harbor12345 
harbor_schema=https 
```
备份原理：
1、备份节点执行脚本，自动生成两个文件：pull_$harbor_endpoint.sh 和 push_$harbor_endpoint.sh
2、执行pull脚本，从目标仓库拉取全部镜像
3、重装harbor节点
4、执行push脚本，推送本地备份镜像到目标仓库
