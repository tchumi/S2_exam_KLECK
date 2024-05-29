#!/bin/bash

# fichier des réponses
fichier="/home/ubuntu/exam_KLECK/exam_jq/res_jq.txt"

echo "1. Affichez le nombre d'attributs par document et le nom de chaque personnage."
echo "1. Affichez le nombre d'attributs par document et le nom de chaque personnage." > $fichier
cat people.json | jq .[] | jq '{name, count:length}' | head -n 12 >> $fichier
echo "Commande : <people.json | jq .[] | jq '{name, count:length}'>"
echo "Il y a 17 attributs par document"
echo -e "\n---------------------------------\n" >> $fichier
echo -e "\n---------------------------------\n"

echo "2. Combien y a-t-il de valeur "unknown" pour l'attribut "birth_year""
echo "2. Combien y a-t-il de valeur "unknown" pour l'attribut "birth_year"" >> $fichier
 cat people.json | jq 'group_by(.birth_year)[] | {birth_year: .[0].birth_year, count: length}' | tail -n 4 >> $fichier
echo "Commande : < cat people.json | jq 'group_by(.birth_year)[] | {birth_year: .[0].birth_year, count: length}' | tail -n 4 >"
echo "Il y a 42 valeurs unknown pour l'attribut birth_year"
echo -e "\n---------------------------------\n" >> $fichier
echo -e "\n---------------------------------\n"

echo "3. Affichez la date de création de chaque personnage et son nom."
echo "3. Affichez la date de création de chaque personnage et son nom." >> $fichier
cat people.json | jq .[] | jq '[.name, .created[0:10]]' | head -n 10 >> $fichier
echo "Commande : <cat people.json | jq .[] | jq '[.name, .created[0:10]]' | head -n 10>"
echo "Voir fichier res_jq.txt pour les 10 premières lignes"
echo -e "\n---------------------------------\n" >> $fichier
echo -e "\n---------------------------------\n"

echo "4. Retrouvez toutes les pairs d'ids (2 ids) des personnages nés en même temps."
echo "4. Retrouvez toutes les pairs d'ids (2 ids) des personnages nés en même temps." >> $fichier
cat people.json | jq 'group_by(.birth_year)[] | {birth_year:.[0].birth_year, id: .[].id, count: length} | select(.count == 2)' >> $fichier
echo "Commande : <cat people.json | jq 'group_by(.birth_year)[] | {birth_year:.[].birth_year, id: .[].id, count: length} | select(.count == 2)'>"
echo "Il y a 6 pairs de personnages nés en même temps"
echo -e "\n---------------------------------\n" >> $fichier
echo -e "\n---------------------------------\n"

echo "5. Renvoyez le numéro du premier film (de la liste) dans lequel chaque personnage a été vu suivi du nom du personnage."
echo "5. Renvoyez le numéro du premier film (de la liste) dans lequel chaque personnage a été vu suivi du nom du personnage." >> $fichier
cat people.json | jq .[] | jq '[.films[0][26:29], .name ]' | head -n 10 >> $fichier
echo "Commande : <people.json | jq .[] | jq '[.films[0][26:29], .name ]'>"
echo "Voir fichier res_jq.txt pour les 10 premières lignes"
echo -e "\n---------------------------------\n" >> $fichier
echo -e "\n---------------------------------\n"

echo -e "\n----------------BONUS----------------\n" >> $fichier
echo -e "\n----------------BONUS----------------\n"

chemin_bonus="/home/ubuntu/exam_KLECK/exam_jq/bonus/"

fichier_bonus=$chemin_bonus"people_6.json"
echo "6. Supprimez les documents lorsque l'attribut height n'est pas un nombre"
cat people.json | jq 'map(select(.height != "unknown"))' > $fichier_bonus
echo "Commande : <people.json | jq 'map(select(.height != "unknown"))'>"
echo "Résultat dans $fichier_bonus"
echo -e "\n---------------------------------\n"

old_fichier_bonus=$fichier_bonus

fichier_bonus=$chemin_bonus"people_7.json"
echo "7. Transformer l'attribut height en nombre"
cat people.json | jq 'map(.height |= tonumber? // empty)' > $fichier_bonus
echo "Commande : <cat people.json | jq 'map(.height |= tonumber? // empty)'>"
echo "Résultat dans $fichier_bonus"
echo -e "\n---------------------------------\n"

old_fichier_bonus=$fichier_bonus
fichier_bonus=$chemin_bonus"people_8.json"
echo "8. Ne renvoyez que les personnages dont la taille est entre 156 et 171"
cat people.json | jq '.[] | select(.height | tonumber? // empty | . >= 156 and . <= 171)' >> $fichier_bonus
echo "Commande : <cat people.json | jq '.[] | select(.height | tonumber? // empty | . >= 156 and . <= 171)'>"
echo "Résultat dans $fichier_bonus"
echo -e "\n---------------------------------\n"

fichier_txt=$chemin_bonus"people_9.txt"
fichier_bonus=$chemin_bonus"people_9.json"
echo "9. Renvoyez le plus petit individu de people_8.json"
cat people.json | jq 'map(select(.height | tonumber? // empty | . >= 156 and . <= 171)) | sort_by(.height)' >> $fichier_bonus
nom=$(jq -r '.[0].name' $fichier_bonus)
taille=$(jq -r '.[0].height' $fichier_bonus)
echo "$nom is $taille tall" >> $fichier_txt
echo "Commande : <cat people.json | jq 'map(select(.height | tonumber? // empty | . >= 156 and . <= 171)) | sort_by(.height)'>"
echo "Résultat dans $fichier_txt"
echo -e "\n---------------------------------\n"
