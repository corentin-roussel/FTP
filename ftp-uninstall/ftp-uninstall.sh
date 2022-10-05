#!/bin/bash

#remove proftpd et ses dépendances
apt purge --auto-remove proftpd

#remove les users créés
deluser --remove-home --remove-all-files Merry
deluser --remove-home --remove-all-files Pippin

#remove line /bin/false in /etc/shells
awk -v p="/bin/false" '$0~"^"p{d=1;next}d&&/^\S/{d=0}!d' /etc/shells