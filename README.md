# Firecore Deployment

Déploiement du module Fireco via Ansible





## Utilisation



### 1. Configuration minimale du Raspberry

Création creation_image_raspbian_personnalisee.md

- Raspian > 4.9
- Connecté au même réseau que la machine distante
- Activation du SSH
- Clé SSH de l'ordinateur distant ajouté sur le Raspberry
  - Création du dossier `.ssh/` sur le Raspberry
  - Commande distante `cat ~/.ssh/id_rsa.pub | ssh pi@<IP>  'cat >> .ssh/authorized_keys'`
  - Tester la connection en ssh avec le Raspberry (Si la manip fonctionne, il ne vous demandera pas de password)



### 2. Installation de Ansible sur la machine distante

Via https://docs.ansible.com/ansible/latest/intro_installation.html



### 3. Configuration/Exécution Playbook 

**Mettre à jour le host**
Mettre à jour le fichier host avec l'IP du Raspberry à installer



**Lancer l'installation**
Console distante : `ansible-playbook -i hosts tasks/installbook.yml`



## Auteurs

- Nicolas SAGOT - @Lyoko17220