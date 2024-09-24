#Guide d'utilisation des scripts
Pour utiliser ces scripts, installez Ansible et Git.

  apt install ansible git -y

Clonez le repo sur la machine ciblée

  git clone https://github.com/CamerD/di3-p1-cdes.git

Allez dans di3-p1-cdes et sélectionnez le script souhaité.

init.sh permet d'initialiser une machine.
Il permet :
  - La configuration de la carte réseau
  - La configuration du hostname
  - La configuration du DNS et du resolv.conf
  - L'installation des dépendances via APT

master.yml permet l'installation et le paramétrage des noeuds master du cluster k8s.

worker.yml permet l'installation et le paramétrage des noeuds worker du cluster k8s.
