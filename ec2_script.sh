#!/bin/bash

sudo apt update -y

sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

cd /home/ubuntu
git clone https://github.com/riteshsingh07/python-fastapi-app.git
cd python-fastapi-app

docker build -t python-api-image:latest .

docker run -d -p5555:5555 python-api-image:latest

sudo usermod -aG docker ubuntu && newgrp docker