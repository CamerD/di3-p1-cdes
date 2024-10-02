# Guide d'utilisation des scripts
Pour utiliser ces scripts, installez Ansible et Git.

`apt install ansible git -y`

Clonez le repo sur la machine ciblée

`git clone https://github.com/CamerD/di3-p1-cdes.git`

Allez dans di3-p1-cdes et sélectionnez le script souhaité.

init.sh permet d'initialiser une machine.
Il permet :
  - La configuration de la carte réseau
  - La configuration du hostname
  - La configuration du DNS et du resolv.conf
  - L'installation des dépendances via APT

master.yml permet l'installation et le paramétrage des noeuds master du cluster k8s.

worker.yml permet l'installation et le paramétrage des noeuds worker du cluster k8s.

Pour utiliser un des scripts yaml, utilisez la commande ansible-playbook à la racine du repo. Voici un exemple avec init.yml :
`ansible-playbook init.yml`

Configuration manuelle de longhorn
Ajout du repo de longhorn :
`helm repo add longhorn https://charts.longhorn.io && helm repo update`
`helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace --version 1.7.1`
(Le package open-iscsi doit être installé sur l'ensemble des noeuds pour que longhorn puisse fonctionner.)

Configuration manuelle de traefik
Ajout du repo traefik : 
`helm repo add traefik https://traefik.github.io/charts && helm repo update`
`helm install traefik traefik/traefik --namespace traefik --create-namespace -f ~/deploy/common/traefik/values.yaml`

Configuration manuelle de keycloak
Ajour du repo de bitnami :
`helm repo add bitnami https://charts.bitnami.com/bitnami && helm repo update`
Pour l'environnement de dev :
`helm install keycloak bitnami/keycloak -n dev -f ~/deploy/dev/keycloak/bitnami/values.yaml`
Pour l'environnement de prod :
`helm install keycloak bitnami/keycloak -n prod -f ~/deploy/prod/keycloak/bitnami/values.yaml`

Configuration manuelle de rabbitmq
Pour l'environnement de dev :
`helm install rabbitmq bitnami/rabbitmq -n dev -f ~/deploy/dev/rabbitmq/values.yaml`
Pour l'environnement de prod :
`helm install rabbitmq bitnami/rabbitmq -n prod -f ~/deploy/prod/rabbitmq/bitnami/values.yaml`
