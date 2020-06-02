#' @title prenoms_fichier_initial
#' @description Auteurs: Mike Campbell et son merveilleux site "Behind The Name"
#' @format A data frame with 11627 rows and 4 variables:
#' \describe{
#'   \item{\code{X01_prenom}}{factor prenom}
#'   \item{\code{X02_genre}}{factor sexe}
#'   \item{\code{X03_langage}}{factor origine}
#'   \item{\code{X04_fréquence}}{num frequence par million}

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
#'   \item{\code{african}}{factor proportion de prenoms african par departement}
#'   \item{\code{arabic}}{factor proportion de prenoms arabic par departement}
#'   \item{\code{basque}}{factor proportion de prenoms basque par departement}
#'   \item{\code{breton}}{factor proportion de prenoms breton par departement}
#'   \item{\code{bulgarian}}{factor proportion de prenoms bulgarian par departement}
#'   \item{\code{catalan}}{factor proportion de prenoms catalan par departement}
#'   \item{\code{celtic}}{factor proportion de prenoms celtic par departement}
#'   \item{\code{croatian}}{factor proportion de prenoms croatian par departement}
#'   \item{\code{czech}}{factor proportion de prenoms czech par departement}
#'   \item{\code{danish}}{factor proportion de prenoms danish par departement}
#'   \item{\code{dutch}}{factor proportion de prenoms dutch par departement}
#'   \item{\code{english}}{factor proportion de prenoms english par departement }
#'   \item{\code{finnish}}{factor proportion de prenoms finnish par departement}
#'   \item{\code{french}}{factor proportion de prenoms french }
#'   \item{\code{german}}{factor proportion de prenoms german par departement}
#'   \item{\code{greek}}{factor proportion de prenoms greek par departement}
#'   \item{\code{hungarian}}{factor proportion de prenoms hungarian par departement}
#'   \item{\code{icelandic}}{factor proportion de prenoms icelandic par departement}
#'   \item{\code{indian}}{factor proportion de prenoms indian par departement}
#'   \item{\code{irish}}{factor proportion de prenoms irish }
#'   \item{\code{italian}}{factor proportion de prenoms italian }
#'   \item{\code{japanese}}{factor proportion de prenoms japanese par departement}
#'   \item{\code{jewish}}{factor proportion de prenoms jewish par departement}
#'   \item{\code{macedonian}}{factor proportion de prenoms macedonian par departement}
#'   \item{\code{norwegian}}{factor proportion de prenoms norwegian par departement}
#'   \item{\code{persian}}{factor proportion de prenoms persian par departement}
#'   \item{\code{polish}}{factor proportion de prenoms polish par departement}
#'   \item{\code{portuguese}}{factor proportion de prenoms portuguese par departement}
#'   \item{\code{provençal}}{factor proportion de prenoms provençal par departement}
#'   \item{\code{romanian}}{factor proportion de prenoms romanian par departement}
#'   \item{\code{russian}}{factor proportion de prenoms russian par departement}
#'   \item{\code{scandinavian}}{factor proportion de prenoms scandinavian par departement}
#'   \item{\code{scottish}}{factor proportion de prenoms scottish par departement}
#'   \item{\code{serbian}}{factor proportion de prenoms serbian par departement}
#'   \item{\code{slovak}}{factor proportion de prenoms slovak par departement}
#'   \item{\code{slovene}}{factor proportion de prenoms slovene par departement}
#'   \item{\code{swedish}}{factor proportion de prenoms swedish par departement}
#'   \item{\code{turkish}}{factor proportion de prenoms turkish par departement}
#'   \item{\code{ukrainian}}{factor proportion de prenoms ukrainian par departement}
#'   \item{\code{welsh}}{factor proportion de prenoms welsh par departement}
#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"table_dep"


#' @title table_nat
#' @description table departementale des proportions deprenoms par origine
#' @format A data frame with 119 rows and 44 variables:
#' \describe{
#'   \item{\code{annee}}{factor annee}
#'   \item{\code{spanish}}{factor proportion de prenoms espagnol }
#'   \item{\code{african}}{factor proportion de prenoms african }
#'   \item{\code{arabic}}{factor proportion de prenoms arabic }
#'   \item{\code{basque}}{factor proportion de prenoms basque }
#'   \item{\code{bosnian}}{factor proportion de prenoms bosnian }
#'   \item{\code{breton}}{factor proportion de prenoms breton }
#'   \item{\code{bulgarian}}{factor proportion de prenoms bulgarian }
#'   \item{\code{catalan}}{factor proportion de prenoms catalan }
#'   \item{\code{celtic}}{factor proportion de prenoms celtic }
#'   \item{\code{croatian}}{factor proportion de prenoms croatian }
#'   \item{\code{czech}}{factor proportion de prenoms czech }
#'   \item{\code{danish}}{factor proportion de prenoms danish }
#'   \item{\code{dutch}}{factor proportion de prenoms dutch }
#'   \item{\code{english}}{factor proportion de prenoms english }
#'   \item{\code{finnish}}{factor proportion de prenoms finnish }
#'   \item{\code{french}}{factor proportion de prenoms french }
#'   \item{\code{german}}{factor proportion de prenoms german }
#'   \item{\code{greek}}{factor proportion de prenoms greek }
#'   \item{\code{hebrew}}{factor proportion de prenoms hebrew }
#'   \item{\code{hungarian}}{factor proportion de prenoms hungarian }
#'   \item{\code{irish}}{factor proportion de prenoms irish }
#'   \item{\code{italian}}{factor proportion de prenoms italian }
#'   \item{\code{icelandic}}{factor proportion de prenoms icelandic }
#'   \item{\code{indian}}{factor proportion de prenoms indian }
#'   \item{\code{japanese}}{factor proportion de prenoms japanese }
#'   \item{\code{jewish}}{factor proportion de prenoms jewish }
#'   \item{\code{macedonian}}{factor proportion de prenoms macedonian }
#'   \item{\code{norwegian}}{factor proportion de prenoms norwegian }
#'   \item{\code{persian}}{factor proportion de prenoms persian }
#'   \item{\code{polish}}{factor proportion de prenoms polish }
#'   \item{\code{portuguese}}{factor proportion de prenoms portuguese }
#'   \item{\code{provençal}}{factor proportion de prenoms provençal }
#'   \item{\code{romanian}}{factor proportion de prenoms romanian }
#'   \item{\code{russian}}{factor proportion de prenoms russian }
#'   \item{\code{scandinavian}}{factor proportion de prenoms scandinavian }
#'   \item{\code{scottish}}{factor proportion de prenoms scottish }
#'   \item{\code{serbian}}{factor proportion de prenoms serbian }
#'   \item{\code{slovak}}{factor proportion de prenoms slovak }
#'   \item{\code{slovene}}{factor proportion de prenoms slovene }
#'   \item{\code{swedish}}{factor proportion de prenoms swedish }
#'   \item{\code{turkish}}{factor proportion de prenoms turkish }
#'   \item{\code{ukrainian}}{factor proportion de prenoms ukrainian }
#'   \item{\code{welsh}}{factor proportion de prenoms welsh }

#'}
#' @source \url{https://www.insee.fr/fr/statistiques/2540004}
"table_nat"
