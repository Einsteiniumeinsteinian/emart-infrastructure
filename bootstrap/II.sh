#!/bin/bash
apt update
apt install docker.io -y
[ $? -eq 0 ] && echo "installation successful" >> /tmp/startup.logs || { echo "installation failed." >> /tmp/startup.logs; exit 1;}
systemctl enable docker
systemctl status docker >> /tmp/startup.logs
usermod -aG docker ubuntu
id ubuntu >> /tmp/startup.logs
su - ubuntu
docker pull einsteinnwizu/emart_image:latest
docker run -d -p 80:80 --name emart_container einsteinnwizu/emart_image:main