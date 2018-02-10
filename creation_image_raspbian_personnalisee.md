# Fiche de route

#### But du document :

Expliquer les démarches exécutées au court de la période de développement afin de pouvoir, en cas d'erreur, revenir aux étapes antérieures, ainsi que de lister les démarches effectuées pour s'en resservir par la suite.

#### Commandes bash utilisées

##### Exécution d'un script au démarrage de Raspbian

Modifier le fichier `/etc/rc.local`.

Ajouter les commandes bash avant la ligne contenant le `exit 0`.

**:warning: Créer un fichier rc.local.old en cas de problème(s). :warning:**

On vérifie si le nom du raspberry a été changé ou non.

Bloque l'exécution du script au premier démarrage du raspberry.

```bash
_RPIHOSTNAME=$(raspi-config nonint get_hostname)
if [ "$_RPIHOSTNAME" != "raspberrypi" ];then
  sh /firecoboot/firstboot.sh
fi
```

:warning: **Pour les phases de test, réadapter avec la création d'un fichier init afin de simplifier. :warning:**



##### Génération et attribution du nouveau nom d'hôte du RPI

```bash
$NHOST=$(head -c 500 /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
raspi-config nonint do_hostname $NHOST
```



##### Configuration des services basiques du RPI

```bash
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_vnc 0
sudo service bluetooth stop
```



##### Redéfinition de la langue du clavier

Afin de palier aux soucis lié aux lignes de commandes, nous avons décider de créer notre propre fichier de configuration du clavier dans le dossier `/firecoboot/new_conf` appelé également `keyboard` attribuant uniquement la langue *fr* au clavier. On le copie donc dans le dossier `/etc/default` afin de remplacer le fichier original ayant la langue *gb* par défaut.

**/etc/default/keyboard**

```bash
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="gb"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
```

**/firecoboot/new_conf/keyboard**

```bash
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="fr"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
```



**Copie du fichier de configuration du clavier**

```bash
cp -f /firecoboot/new_conf/keyboard /etc/default/keyboard
```





Redémarrer le **RPI** via `shutdown -r now` après toutes modifications système.

# ANNEXE

**RPI** : Raspberry Pi (ici le Pi 3)