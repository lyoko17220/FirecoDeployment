# Fiche de route

#### But du document :

Expliquer les démarches exécutées au court de la période de développement afin de pouvoir, en cas d'erreur, revenir aux étapes antérieures, ainsi que de lister les démarches effectuées pour s'en resservir par la suite.

#### Commandes bash utilisées

##### Exécution d'un script au démarrage de Raspbian

Modifier le fichier `/etc/rc.local`.

Ajouter les commandes bash avant la ligne contenant le `exit 0`.

**:warning: Créer un fichier rc.local.old en cas de problème(s). :warning:**

On vérifie si le fichier `/firecoboot/init` existe ou non.

Bloque l'exécution du script au premier démarrage du raspberry.

```bash
if [ ! -f "/firecoboot/init" ];then 
  touch init 
  sh /firecoboot/firstboot.sh
fi
```



##### Génération et attribution du nouveau nom d'hôte du RPI

```bash
$NHOST=$(head -c 500 /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
raspi-config nonint do_hostname $NHOST
```



##### Configuration des services basiques du RPI

**Activation du service SSH et de VNC**

```bash
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_vnc 0
```

**Désactivation du bluetooth**

Afin de désactiver le bluetooth, une intervention empêchant le chargement des drivers doit être faite. On créer ici dans le dossier `/firecoboot/new_conf` un fichier `raspi-blacklist.conf` qui sera copier dans le répertoire `/etc/modprobe.d`.

**/firecoboot/new_conf/raspi-blacklist.conf**

```bash
blacklist btbcm
blacklist hci_uart
```

```bash
cp -f /firecoboot/new_conf/raspi-blacklist.conf /etc/modprobe.d/raspi-blacklist.conf
```



##### Redéfinition de la langue du clavier

Afin de palier aux soucis lié aux lignes de commandes, nous avons décider de créer notre propre fichier de configuration du clavier dans le dossier `/firecoboot/new_conf` appelé également `lxkeymap.cfg` attribuant uniquement la langue *fr* au clavier. On le copie donc dans le dossier `/home/pi/.config/lxkeymap.cfg` (lié au moteur graphique) afin de remplacer le fichier original ayant la langue *gb* par défaut.

**/home/pi/.config/lxkeymap.cfg**

```bash
[Global]
layout = gb
variant = 
option = 
```

**/firecoboot/new_conf/lxkeymap.cfg**

```bash
[Global]
layout = fr
variant = 
option = 
```

**Copie du fichier de configuration du clavier**

```bash
cp -f /firecoboot/new_conf/lxkeymap.cfg /home/pi/.config/lxkeymap.cfg
```



##### Configuration du Wi-Fi du RPI

Création du fichier `/firecoboot/new_conf/wpa_supplicant.conf` contenant les différents SSID ainsi que les clés WPA des différents réseaux.

**Exemple d'écriture d'un réseau dans le fichier**

```bash
network={
	ssid="nom_du_routeur"
	psk="clef_du_reseau"
	key_mgmt=securite_du_reseau
}
```

**Copie du fichier de configuration**

```bash
cp -f /firecoboot/new_conf/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
```



##### Création du dossier .ssh

```bash
mkdir -m 777 /home/pi/.ssh
```



Redémarrer le **RPI** via `shutdown -r now` après toutes modifications système.



#### Création de l'image "finale"

La ligne de commande permettant de créer une image .iso est :

```bash
genisoimage -o nom_image.iso /chemin/de/l/image
```



# ANNEXE

**RPI** : Raspberry Pi (ici le Pi 3)