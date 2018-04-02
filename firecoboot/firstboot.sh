#!/bin/bash

#Configuration du hostname du RaspberryPi
_NHOST=$(head -c 500 /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
raspi-config nonint do_hostname $_NHOST

#Configurations des services
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_vnc 0

#Interactions sur le bluetooth
cp -f /firecoboot/new_conf/raspi-blacklist.conf /etc/modprobe.d/raspi-blacklist.conf

#Attribution du clavier AZERTY
cp -f /firecoboot/new_conf/lxkeymap.cfg /home/pi/.config/lxkeymap.cfg

#Configuration du Wi-Fi
cp -f /firecoboot/new_conf/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf

#Créer le dossier .ssh
mkdir -m 777 /home/pi/.ssh

#Créer la racine NAS
mkdir -m 777 /firecodata

#Reboot du Raspberry après configuration
shutdown -r now
