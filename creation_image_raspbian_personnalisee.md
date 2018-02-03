# Fiche de route

#### But du document :

Expliquer les démarches exécutées au court de la période de développement afin de pouvoir, en cas d'erreur, revenir aux étapes antérieures, ainsi que de lister les démarches effectuées pour s'en resservir par la suite.



#### Exécution d'un script au démarrage de Raspbian

Modifier le fichier /etc/rc.local.

Ajouter les commandes bash avant la ligne contenant le "exit 0".

**:warning: Créer un fichier rc.local.old en cas de problème(s). :warning:**

On vérifie la présence du fichier init dans le firecoboot (créer au préalable par nous même).

Bloque l'exécution du script au premier démarrage du raspberry.

```bash
if [ ! -f "/firecoboot/init" ];then
  touch init
  sh /firecoboot/firstboot.sh
fi
```

:warning: **Pour les phases de test, supprimer le fichier init du dossier firecoboot à chaque modification. :warning:**

##### Génération et attribution du new hostname du Raspberry

```bash
$NHOST=$(head -c 500 /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
raspi-config nonint do_hostname $NHOST
```



Redémarrer le Rapsberry via `shutdown -r now` après toutes modifications système.