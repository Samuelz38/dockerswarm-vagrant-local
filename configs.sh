#!/bin/bash

echo "Criando Cluster Swarn Local com Vangrat....."

echo "Atualizando o servidor...."

apt update
apt upgrade

echo "------------------------------------------------"

echo "Instalando o virtualbox...."
sudo apt install virtualbox -y

echo "------------------------------------------------"

echo "Instalando o vagrant...."

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant -y

echo "------------------------------------------------"

echo "Iniciando criação das VMs com Vagrant (pode demorar)....."
vagrant up

echo "Iniciando o master..."
vagrant ssh master -c "docker swarm init --advertise-addr 192.168.56.10"

TOKEN=$(vagrant ssh master -c "docker swarm join-token worker -q" | tr -d '\r')

for node in node1 node2 node3; do
    echo "Unindo $node ao cluster..."
    vagrant ssh $node -c "docker swarm join --token $TOKEN 192.168.56.10:2377"
done

echo "Ambiente pronto! Verificando nodes:"
vagrant ssh master -c "docker node ls"