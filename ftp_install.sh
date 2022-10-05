#!/bin/bash


#upgrade et update du systéme vierge install de proftpd et vérification de l'installation avec la commande de la version proftpd
apt -y upgrade && apt -y update
apt install -y proftpd* openssl
proftpd --version

#commande pour restart proftpd avant d'enregistrer les changements effectués
systemctl restart proftpd

#commande qui nous permet de créer un dossier ssl pour pouvoir placer le certificat et la clé ssl
mkdir /etc/proftpd/ssl

#copie des des fichiers originaux avant de les remplacer pour prévenir les problémes 
cp /etc/proftpd/proftpd.conf /etc/proftpd/proftpd.conf.ori
cp /etc/proftpd/tls.conf /etc/proftpd/tls.conf.ori
cp /etc/proftpd/modules.conf /etc/proftpd/modules.conf.ori

#copie des fichiers modifiés vers le dossier parent proftpd
cp proftpd.conf /etc/proftpd/proftpd.conf
cp modules.conf /etc/proftpd/modules.conf
cp tls.conf /etc/proftpd/tls.conf

systemctl restart proftpd
#commande permettant de donner accés a l'utilisateur uniqument au serveur ftp
echo "/bin/false" >> /etc/shells

#commande qui crée des utilisateurs
printf "kalimac\nkalimac\nMeriadoc-Brandybuck\n\n\n\n\no\n" | adduser --force-badname Merry --shell /bin/false
printf "secondbreakfast\nsecondbreakfast\nPeregrin-Took\n\n\n\n\no\n" | adduser --force-badname Pippin --shell /bin/false
systemctl restart proftpd

#création de la clé et du certificat ssl afin de pouvoir se connecter en tls/ssl
printf "ER\nMiddleEarth\nTheShire\nHobbit\nFotR\nFrodoBaggins\n\n" | sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/proftpd/ssl/proftpd.key.pem -out /etc/proftpd/ssl/proftpd.cert.pem -nodes -days 365
systemctl restart proftpd