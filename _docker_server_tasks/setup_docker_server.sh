#!/bin/bash

mkdir /opt/secrets
echo "Yeet, my good sir" > /opt/secrets/yeet
echo '{"ACCESS_KEY":"${PostgresBackupUserCredentials}","SECRET_KEY":"${PostgresBackupUserCredentials.SecretAccessKey}"}' > /opt/secrets/pass
echo "Running update" >> /var/log/setup.log
apt-get -y update >> /var/log/setup.log

apt install docker.io  -y >> /var/log/setup.log
echo "apt install docker.io" >> /var/log/setup.log

groupadd docker
usermod -aG docker $USER
newgrp docker 
echo "Groups done" >> /var/log/setup.log

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

echo POSTGRES_USER=root >> .env
echo POSTGRES_PASSWORD=root >> .env
echo POSTGRES_DB=site-data >> .env
echo S3_PG_BACKUP_KEY=${PostgresBackupUserCredentials} >> .env
echo S3_PG_BACKUP_SECRET=${PostgresBackupUserCredentials.SecretAccessKey} >> .env
echo ".env:"  >> /var/log/setup.log  
cat .env >> /var/log/setup.log  

echo "Running docker compose" >> /var/log/setup.log  
docker-compose --env-file .env up  >> /var/log/setup.log  2>&1