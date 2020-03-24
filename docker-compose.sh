#!/bin/bash
version=1.25.4
curl -L https://get.daocloud.io/docker/compose/releases/download/${version}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
