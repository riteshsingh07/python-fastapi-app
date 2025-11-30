#!/bin/bash

apt update -y
apt install -y docker.io git

systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

cd /home/ubuntu

# Clone the correct repo
git clone https://github.com/YOUR_USERNAME/python-fastapi-app.git

# Move into the actual cloned directory
cd python-fastapi-app

# Build docker image
docker build -t python-api-image:latest .

# Run the container
docker run -d -p 5555:5555 python-api-image:latest
