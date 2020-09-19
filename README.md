### Install latest version of dokcer-ce in centos7 or ubuntu
```
# install docker
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun && systemctl enable --now docker

# install docker with huaweicloud registry mirror
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/docker-ce.sh | sh

# install docker-compose
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/docker-compose.sh | sh
```

## retag docker
```
wget https://raw.githubusercontent.com/willzhang/shell/master/dockerctl
sh dockerctl images.txt registry
```

## docker run shadowsocks
```
# install shadowsocks server in server side
curl -fsSL https://raw.githubusercontent.com/willzhang/shell/master/shadowsocks.sh | sh

# install shadowsocks in windows android or ios
  # https://shadowsocks.org/en/download/clients.html
  # https://github.com/shadowsocks/shadowsocks-windows/releases
  # https://github.com/shadowsocks/shadowsocks-android/releases

#default connection info
port:6443
password:123456
Encryption mode：chacha20-ietf-poly1305
```
