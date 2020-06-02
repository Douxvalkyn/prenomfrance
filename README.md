
<!-- README.md is generated from README.Rmd. Please edit that file -->

Le package **prenomfrance** améliore la connaissance de la démographie
française à partir de ses prénoms. A partir des bases de prenoms *Insee*
actualisées chaque année, ainsi que de la base de données du site
*Behind The name*, ce package fournit des outils de visualisation sur
les statistiques des prénoms donnés aux enfants.

Pour lancer l’application R Shiny: run\_prenomfrance()

L’application est composée de 3 onglets:

\_ main:

  - carte de la proportion de prénoms donnés aux enfants par origine et
    par département

  - carte de la répartition des origines des prenoms

  - graphe de l’évolution des origines des prénoms

  - graphe de la concentration des prenoms

\_ popularité:

  - nuage de mots des prénoms

  - top 10 des prénoms (masculin, féminin), dans une plage d’année
    choisie, et par origine

  - graphe de l’évolution de la popularité d’un prénom sélectionné

\_ reseau:

  - pour un prénom sélectionné, le réseau des prénoms voisins, selon la
    distance de Jaro-Winkler
