#!/bin/bash

# Désactiver le swap
sudo swapoff -a

# Commenter les lignes de swap dans /etc/fstab
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Créer le fichier de configuration pour les modules du noyau
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

# Charger les modules du noyau
sudo modprobe overlay
sudo modprobe br_netfilter

# Créer le fichier de configuration pour sysctl
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Appliquer les paramètres sysctl
sudo sysctl --system

# Mettre à jour les paquets
sudo apt update

# Installer containerd
sudo apt -y install containerd

# Configurer containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
