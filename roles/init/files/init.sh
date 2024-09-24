#!/bin/bash

# Mettre a  jour les paquets et installer les paquets necessaires
apt-get update
apt-get install -y hostname ifupdown systemd sudo curl gpg

# Demander le nom de la machine souhaitee
read -p "Veuillez entrer le nom de la machine souhaitee : " hname

# Demander l'adresse IP souhaitee
read -p "Veuillez entrer l'adresse IP souhaitee : " ip_address

# Definir le fichier hosts
sudo tee /etc/hosts <<EOF
127.0.0.1 localhost
127.0.1.1 $hname

192.168.14.180 master-01
192.168.14.181 worker-01
192.168.14.182 worker-02

192.168.14.183 master-02
192.168.14.184 worker-03
192.168.14.185 worker-04
EOF

# Definir le nom de la machine
hostnamectl set-hostname "$hname"

# Definir l'adresse IP
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
EOF

# Definir les DNS
sudo tee /etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF


# Acces SSH en root
echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config

# Redemarrer pour appliquer les changements
reboot
