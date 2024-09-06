# Installation de Nextcloud et du proxy inverse Traefik

Nextcloud et Traefik fonctionnent grâce à docker. Pour pouvoir faire fonctionner ce playbook, docker doit être installé.

## Premièrement 

Le playbook va créer le dossier nxc à la racine de root. Deux fichier docker-compose "nextcloud.yml" et "traefik.yml" y seront copiés depuis le répertoire "files" du playbook.
Enfin, dans le répertoire nxc, seront créé les dossier certs et config.

### Deuxièmement

Le playbook va copier les fichiers placés dans "files" et les placer dans les bons répertoires.

#### Troisièmement

Le playbook va créer un certificat x509 grâce à mkcert, il s'agit d'une solution permettant de créer 
des certificats auto-signés. Pour cela il télécharge mkcert sur s-adm (utiliser le getall).

mkcert sera placé dans : /usr/local/bin/ 

Pour créer le certificat le playbook va executer des lignes de commandes (lancé depuis nxc/) :
```
/usr/local/bin/mkcert -install # Installe mkcert
/usr/local/bin/mkcert -key-file key.pem -cert-file cert.pem "hôte.domaine.local" "*.domaine.local" #Crée le certificat le DNS spécifié
```
##### Quatrièmement

Le playbook va lancer les fichier "docker-compose" à savoir : nextcloud.yml et traefik.yml. 
Cela va installer les solutions automatiquement. Nextcloud est alors fonctionnel avec
un proxy inverse qui va rediriger en HTTPS.


ATTENTION : Après avoir relancé la VM, executez le script "nxc-start.sh" afin d'installer les piles applicatives. 
Une fois le script fini, accedez au site :
https://s-nxc.gsb.lan
