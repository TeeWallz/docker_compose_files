#!/bin bash

#Cifs for fileshare mount and docker obviously
sudo su
sudo apt install -y nfs-common docker.io
sudo apt upgrade

# Add Media and main SHARE as mounts/etc/fstab
printf "192.168.0.100:/mnt/Raid_Pool/SHARE /mnt/share nfs rw,hard,intr,rsize=8192,wsize=8192,timeo=14  0 0\n" >> /etc/fstab
printf "192.168.0.100:/mnt/Raid_Pool/SHARE/MEDIA /mnt/media nfs rw,hard,intr,rsize=8192,wsize=8192,timeo=14  0 0\n" >> /etc/fstab
mkdir -p /mnt/share
mkdir -p /mnt/media
sudo mount -a

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker 

docker volume create portainer_data
docker run -d -p 8000:8888 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
