#!/bin/bash

#remove proftpd et ses dépendances
apt purge --auto-remove proftpd-*

#remove les users créés
deluser --remove-home --remove-all-files Merry
deluser --remove-home --remove-all-files Pippin
