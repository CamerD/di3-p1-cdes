#!/bin/bash

# Mettre à jour les paquets et installer les paquets nécessaires
apt-get update
apt-get install -y hostname ifupdown systemd sudo curl

# Demander le nom de la machine souhaitée
read -p "Veuillez entrer le nom de la machine souhaitée : " hname
full_hostname="$hname.di3.reseau-labo.fr"
# Demander l'adresse IP souhaitée
read -p "Veuillez entrer l'adresse IP souhaitée : " ip_address

# Définir le fichier hosts
sudo tee /etc/hosts <<EOF
127.0.0.1 localhost
127.0.1.1 $full_hostname $hname

192.168.14.180 master-01.di3.reseau-labo.fr    master-01
192.168.14.181 worker-01.di3.reseau-labo.fr    worker-01
192.168.14.182 worker-02.di3.reseau-labo.fr    worker-02

192.168.14.183 master-02.di3.reseau-labo.fr    master-02
192.168.14.184 worker-03.di3.reseau-labo.fr    worker-03
192.168.14.185 worker-04.di3.reseau-labo.fr    worker-04
EOF

# Définir le nom de la machine
hostnamectl set-hostname "$full_hostname"

# Définir l'adresse IP
sudo tee /etc/network/interfaces <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens18
iface ens18 inet static
    address $ip_address
    netmask 255.255.255.0
    gateway 192.168.14.1
    dns-nameservers 192.168.14.1 8.8.8.8
EOF

# Accès SSH en root
echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config

# Redémarrer pour appliquer les changements
reboot
