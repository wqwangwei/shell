#!/bin/bash
docker volume create portainer_data
docker run -itd --name=myportainer --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
