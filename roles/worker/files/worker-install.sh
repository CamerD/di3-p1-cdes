#!/bin/bash

# Redémarrer et activer le service containerd
sudo systemctl restart containerd
sudo systemctl enable containerd

# Ajouter le dépôt Kubernetes
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Ajouter la clé GPG pour le dépôt Kubernetes
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Mettre à jour les paquets
sudo apt update

# Installer kubelet, kubeadm et kubectl
sudo apt install kubelet kubeadm kubectl -y

# Empêcher la mise à jour automatique de kubelet, kubeadm et kubectl
sudo apt-mark hold kubelet kubeadm kubectl

kubeadm join master-01:6443 --token nbrud1.46u01rsnmi989bgi --discovery-token-ca-cert-hash sha256:73d93720dd7092a5ac45e92c87616c61e312bcddf7c00aa9b9c9ada895e3f3ec
