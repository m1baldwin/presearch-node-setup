#!/bin/bash

#Based on the instructions here: https://docs.docker.com/engine/install/ubuntu/
#and here: https://docs.docker.com/engine/install/linux-postinstall/

echo "Welcome! Let's setup your node!"

if [ -z $1 ]
then
	echo "You need to provide the presearch registration key"
	exit 1
fi

PRESEARCH_REGISTRATION_CODE=$1

echo "You provided the following PRESEARCH_REGISTRATION_CODE=$PRESEARCH_REGISTRATION_CODE"

#Update apt package and install packages to allow apt t o use repo over https
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#add docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#setup the stable repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/dcoker.list > /dev/null

#Update Apt and install dcoker engine, containerd, and docker compose
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

#Hello-world
sudo docker run hello-world

#add user to docker group
sudo groupadd docker
sudo usermod -aG docker $USER

#update group settings without needign to log out
newgrp docker

#setup and run presearch
source ./presearch-node-start.sh $PRESEARCH_REGISTRATION_CODE
