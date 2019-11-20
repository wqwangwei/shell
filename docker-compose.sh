version=1.24.1
curl -L https://get.daocloud.io/docker/compose/releases/download/${version}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/${version}/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
