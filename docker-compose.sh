#!/bin/bash
curl -s https://api.github.com/repos/docker/compose/releases/latest \
  | grep browser_download_url \
  | grep Linux-x86_64 \
  | grep -v sha256 \
  | cut -d '"' -f 4 \
  | xargs curl -Lo /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
