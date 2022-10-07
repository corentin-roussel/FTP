#!/bin/bash

#variable pour le fichier csv
file='Shell_Userlist.csv'
#permet d'enlever les espaces non voulu
awk '/^$/{next}{sub(/^[[:blank:]]*/,"");gsub(/[[:blank:]]*,[[:blank:]]*/,",")}1' $file
#début de la boucle while avec ifs pour lire le fichier csv 
while IFS="," read -r id prenom nom mdp role;do
#si id = id useradd
    if [ $"id" = $"id" ];
    then 
        useradd --badnames -u $id -m ${prenom}
        echo $prenom:$mdp | chpasswd
#si role du caractéres 0 au 5 = Admin then usermod sudo
            if [ ${role:0:5} = "Admin" ];
            then 
                usermod --shell /bin/bash -aG sudo ${prenom}
            fi
                if [ ${role:0:4} = "User" ];
                then
                    usermod --shell /bin/false ${prenom}
                fi
    fi
done < <(tail -n +2 $file)