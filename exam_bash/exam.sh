# Script de récupération des ventes de cartes graphiques via l'API dans un fichier texte


# Références de cartes graphiques 
refCarteGraphique[0]="rtx3060"
refCarteGraphique[1]="rtx3070"
refCarteGraphique[2]="rtx3080"
refCarteGraphique[3]="rtx3090"
refCarteGraphique[4]="rx6700"

# fichier des ventes
fichier="sales.txt"

function requeteApi {
    # argument 1 : référence de la carte graphique
    response=$(curl ""http://0.0.0.0:5000"/$1")
    echo "$response"
}

function DocumenteVenteReference {
    # argument 1 : référence
    # argument 2 : vente
    # argument 3 : fichier des ventes
    echo "$1:$2" >> $3
}

# extraction des ventes de cartes graphiques à date
echo "$(date)" >> $fichier
for reference in "${refCarteGraphique[@]}"
do
    vente=$(requeteApi $reference)
    DocumenteVenteReference $reference $vente $fichier
done