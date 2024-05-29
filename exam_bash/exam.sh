#!/bin/bash
# Script de récupération des ventes de cartes graphiques via l'API dans un fichier texte

# fichier des ventes
fichier="/home/ubuntu/exam_KLECK/exam_bash/sales.txt"

# Références de cartes graphiques 
refCarteGraphique[0]="rtx3060"
refCarteGraphique[1]="rtx3070"
refCarteGraphique[2]="rtx3080"
refCarteGraphique[3]="rtx3090"
refCarteGraphique[4]="rx6700"

function requeteApi {
    # argument 1 : référence de la carte graphique
    # retourne la vente de la carte graphique
    response=$(curl ""http://0.0.0.0:5000"/$1")
    echo "$response"
}

function documenterVenteReference {
    # argument 1 : référence de la carte graphique
    # argument 2 : vente de la carte graphique
    # argument 3 : fichier des ventes
    # en sortie : écriture de la vente dans le fichier des ventes
    echo "$1:$2" >> $3
}

# boucle principale : extraction des ventes de cartes graphiques à date
#----------------------------------------------------------------------
echo "$(date)" >> $fichier
for reference in "${refCarteGraphique[@]}"
do
    vente=$(requeteApi $reference)
    documenterVenteReference $reference $vente $fichier
done