#' Recherche des prenoms proches, selon la distance de Jaro Winkler, dans une base de données
#'
#' @param prenom prenom dont on cherche des prenoms proches
#' @param seuil_graphe seuil de 0 à 1 en desosus duquel les prenoms sont définis comme proches
#' @param prenoms_all liste des prenoms où on cherche des similarités
#'
#' @return une liste avec un vecteur des prenoms proches, un vecteur des distances au prenom d'interet,
#' et le nb de prénoms proches
#' @export
#'



recherche_prenoms_proches <- function(prenom,seuil_graphe,prenoms_all ){

  # variables auxiliaires
  prenoms_proches<- NULL
  distances=NULL
  j=1

    for (mot in prenoms_all){
      distance <- stringdist::stringdist(prenom, mot,  method="jw")

      if (distance <seuil_graphe & distance >0){
        prenoms_proches[j] <- mot
        distances[j] <- distance
      }
      j=j+1
    }
    prenoms_proches=na.omit(prenoms_proches)
    distances=na.omit(distances)
    nb_prenoms_proches=length(unlist(prenoms_proches))


    liste=list(prenoms_proches,distances, nb_prenoms_proches)

    return(liste)

}


