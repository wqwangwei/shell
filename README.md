### Install latest version of dokcer-ce and docker-compose
```
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/docker-ce.sh | sh

curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/docker-compose.sh | sh

curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun && systemctl enable --now docker
```


### update centos7 kernel
```
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/update_centos7_kernel.sh | sh
```

## docker run shadowsocks
```
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/shadowsocks.sh | sh

#default connection info
port:6443
password:123456
Encryption mode：chacha20-ietf-poly1305
```


##update centos kernel
```
SHELL_NAME=upgrade_centos7_kernel.sh
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/$SHELL_NAME | sh
```
