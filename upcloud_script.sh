#!/bin/bash

#Based on the instructions here: https://docs.docker.com/engine/install/ubuntu/
#and here: https://docs.docker.com/engine/install/linux-postinstall/

echo "Welcome! Let's setup your node!"


PRESEARCH_REGISTRATION_CODE="<add key between quotes"

echo "You provided the following PRESEARCH_REGISTRATION_CODE=$PRESEARCH_REGISTRATION_CODE"

#Rest of the steps snarfed from YFA setup script here: https://controlc.com/e320e790
sudo apt update && sudo apt upgrade -y
curl -fsSL https://get.docker.com -o get-docker.sh

#setup and run presearch
docker run -d --name presearch-auto-updater --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock presearch/auto-updater --cleanup --interval 900 presearch-auto-updater presearch-node
sudo docker pull presearch/node
sudo docker run -dt --name presearch-node --restart=unless-stopped -v presearch-node-storage:/app/node -e REGISTRATION_CODE=$PRESEARCH_REGISTRATION_CODE presearch/node
