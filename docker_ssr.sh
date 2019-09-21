#!/bin/bash
docker rm -f ssserver
docker run -dt \
  --name ssserver \
  -p 6443:6443 \
  -p 6500:6500/udp \
  mritd/shadowsocks \
  -m "ss-server" \
  -s "-s 0.0.0.0 -p 6443 -m chacha20-ietf-poly1305 -k 123456" \
  -x -e "kcpserver" \
  -k "-t 127.0.0.1:6443 -l :6500 -mode fast2"