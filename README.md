### Install latest version of dokcer-ce and docker-compose
```
#默认docker
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun && systemctl enable --now docker

#阿里云mirror
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/docker-ce.sh | sh

curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/docker-compose.sh | sh
```

## docker run shadowsocks
```
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/shadowsocks.sh | sh

#default connection info with ssrclient: https://github.com/shadowsocks/shadowsocks-windows/releases
port:6443
password:123456
Encryption mode：chacha20-ietf-poly1305
```
