#!/bin/bash
echo "Instalando o docker...."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo usermod -aG docker vagrant
echo "Pronto"