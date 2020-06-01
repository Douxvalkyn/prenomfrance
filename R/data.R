#' @title prenoms_fichier_initial
#' @description Auteurs: Mike Campbell et son merveilleux site "Behind The Name"
#' @format A data frame with 11627 rows and 4 variables:
#' \describe{
#'   \item{\code{prenom}}{factor prenom}
#'   \item{\code{genre}}{factor sexe}
#'   \item{\code{langage}}{factor origine}
#'   \item{\code{frequence}}{num frequence par million}

#'}
#' @source \url{https://www.data.gouv.fr/fr/datasets/liste-de-prenoms/}
"prenoms_fichier_initial"


#' @title nat2018_fichier_initial
#' @description Fichier des prenoms 2018 de l'Insee
#' @format A data frame with 636474 rows and 4 variables:
#' \describe{
#'   \item{\code{X.U.FEFF.sexe}}{int sexe}
#'   \item{\code{preusuel}}{factor prenom}
#'   \item{\code{annais}}{factor annee de naissance}
#'   \item{\code{nombre}}{nombre de naissances avec ce prenom}
#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"nat2018_fichier_initial"


#' @title dpt2018_fichier_initial
#' @description Fichier des prenoms 2018 de l'Insee
#' @format A data frame with 3624994 rows and 5 variables:
#' \describe{
#'   \item{\code{X.U.FEFF.sexe}}{int sexe}
#'   \item{\code{preusuel}}{factor prenom}
#'   \item{\code{annais}}{factor annee de naissance}
#'   \item{\code{dpt}}{factor departement}
#'   \item{\code{nombre}}{nombre de naissances avec ce prenom}
#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"dpt2018_fichier_initial"


#' @title base_dep
#' @description base departementale Insee des prenoms enrichie avec les origines des prenoms
#' @format A data frame with 3624994 rows and 6 variables:
#' \describe{
#'   \item{\code{sexe}}{int sexe}
#'   \item{\code{prenom}}{chr prenom}
#'   \item{\code{annais}}{factor annee de naissance}
#'   \item{\code{dpt}}{factor departement de naissance}
#'   \item{\code{nombre}}{int nombre de naissances avec ce prenom}
#'   \item{\code{origine}}{ chr origine du prenom}

#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"base_dep"


#' @title base_nat
#' @description base nationale Insee des prenoms enrichie avec les origines des prenoms
#' @format A data frame with 3624994 rows and 6 variables:
#' \describe{
#'   \item{\code{sexe}}{int sexe}
#'   \item{\code{prenom}}{chr prenom}
#'   \item{\code{annais}}{factor annee de naissance}
#'   \item{\code{nombre}}{int nombre de naissances avec ce prenom}
#'   \item{\code{origine}}{ chr origine du prenom}

#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"base_nat"


#' @title map_dep
#' @description carte des departements français
#' @format A data frame with 101 rows and 3 variables:
#' \describe{
#'   \item{\code{codgeo}}{factor code geographique des departements}
#'   \item{\code{libgeo}}{factor libelle des departements}
#'   \item{\code{geometry}}{list geometrie des departements}

#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"map_dep"



#' @title table_dep
#' @description table departementale des proportions deprenoms par origine
#' @format A data frame with 11781 rows and 43 variables:
#' \describe{
#'   \item{\code{annee}}{factor annee}
#'   \item{\code{dep}}{factor departement}
#'   \item{\code{spanish}}{factor proportion de prenoms espagnol par departement}

#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"table_dep"


#' @title table_nat
#' @description table departementale des proportions deprenoms par origine
#' @format A data frame with 119 rows and 44 variables:
#' \describe{
#'   \item{\code{annee}}{factor annee}
#'   \item{\code{spanish}}{factor proportion de prenoms espagnol en France}

#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"table_nat"
