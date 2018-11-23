#### 需求：

以两个文件内容为参数，批量创建新文件，文件名包含ipaddr.txt中的内容，文件内容包含hostname.txt中的内容。

```shell
[root@localhost ~]# cat ipaddr.txt 
150.20.19.40
150.20.19.41

[root@localhost ~]# cat host.txt 
Server01
Server02

[root@localhost ~]# cat iplist.txt 
150.20.19.40    Server01
150.20.19.41    Server02
```

```vbscript
[root@localhost ~]# cat example.txt 
#$language = "VBScript"
#$interface = "1.0"

Sub main
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString "gandalf@hostname:~>"
  crt.Screen.Send "su - root" & VbCr
  crt.Screen.WaitForString "Password:"
  crt.Screen.Send "Huawei@CLOUD8!" & VbCr
  crt.Screen.WaitForString "hostname:~ #"
  crt.Screen.Send "TMOUT=0" & VbCr
  crt.Screen.Synchronous = False
End Sub
```

#### 实现：

方法1：

```shell
#!/bin/sh
while read a b
do
sed "s/hostname/${b}/g" /root/example.txt > /root/vbfile/$a.txt
done </root/iplist.txt
```

方法2：

```shell
#!/bin/bash
exec 3< "/root/ipaddr.txt"
exec 4< "/root/host.txt"
while read line1<&3 && read line2<&4
do
sed "s/hostname/${line2}/g" /root/example.txt > /root/vbfile/$line1.txt
done
```

执行结果：

```shell
[root@localhost ~]# ll vbfile/
-rw-r--r-- 1 root root 367 Sep 19 18:48 150.20.19.40.txt
-rw-r--r-- 1 root root 367 Sep 19 18:48 150.20.19.41.txt
```



```vbscript
[root@localhost ~]# cat vbfile/150.20.19.40
cat: vbfile/150.20.19.40: No such file or directory
[root@localhost ~]# cat vbfile/150.20.19.40.txt 
#$language = "VBScript"
#$interface = "1.0"

Sub main
  crt.Screen.Synchronous = True
  crt.Screen.WaitForString "gandalf@MCNA01:~>"
  crt.Screen.Send "su - root" & VbCr
  crt.Screen.WaitForString "Password:"
  crt.Screen.Send "Huawei@CLOUD8!" & VbCr
  crt.Screen.WaitForString "MCNA01:~ #"
  crt.Screen.Send "TMOUT=0" & VbCr
  crt.Screen.Synchronous = False
End Sub
```

