Pour générer un token afin de rejoindre le master : 
`kubeadm token create --print-join-command`

Résultat :
```bash
kubeadm join <master-node>:6443 --token <token> --discovery-token-ca-cert-hash <ca-cert-hash> 
--control-plane --certificate-key 3063b76ef8f19ea781aef62988272a45220ca8e65799cfdac4e9483aa721c7a0
```

Pour rejoindre un cluster kubernetes en tant que master, il faut ajouter les arguments : --control-plane --certificate-key <certificate-key>

Pour trouver la clé du certificat : 
`kubeadm init phase upload-certs --upload-certs`


Commande finale :

```bash
kubeadm join <ip-address>:6443\
    --token=<token> \
    --discovery-token-ca-cert-hash sha256:<ca-cert-hash> \
    --control-plane \
    --certificate-key <certificate-key>
```

