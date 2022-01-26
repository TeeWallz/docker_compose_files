#!/bin/bash

sudo apt update
sudo apt install docker.io

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 

docker run hello-world

echo "Getting docker compose" >> /var/log/setup.log
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose  >> /var/log/setup.log 2>&1
chmod +x /usr/local/bin/docker-compose

docker volume create portainer_data >> /var/log/setup.log
docker run -d -p 8000:8000 -p 9443:9443 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    cr.portainer.io/portainer/portainer-ce:2.9.3  >> /var/log/setup.log
echo "Docker done" >> /var/log/setup.log     
