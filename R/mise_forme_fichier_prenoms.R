

#' mise en forme du fichier des prenoms
#'
#' @param fichier_prenoms base de données mondiale provenant du site behind the name
#'
#' @return dataframe mis en forme pour jointure avec fichier insee des prenoms
#' @export
#'

mise_forme_fichier_prenoms = function (fichier_prenoms){

  # selection colonnes prenom et origine
   prenoms <- fichier_prenoms %>%
     dplyr::rename(prenom=X01_prenom, origine=X03_langage) %>%
     dplyr::select(prenom, origine)

  # mettre les prenoms en majuscule
  prenoms$prenom <- stringr::str_to_upper(prenoms$prenom)

  # enlever les accents aux prenoms
  prenoms$prenom <- iconv(as.character(prenoms$prenom),from="UTF-8", to="ASCII//TRANSLIT")
  prenoms$prenom <- gsub("'", '', prenoms$prenom)

  # supprimer les (1), (2), etc en cas de plusieurs lignes pour un même prenom
  prenoms$prenom <-  stringr::str_extract(prenoms$prenom,"^[A-Z]+" )

  # supprimer les lignes NA (caracteres non existants en France)
  prenoms <-prenoms[!(is.na(prenoms$prenom)),]

  # grouper les lignes qui concernent les mêmes prenoms
  prenoms <- aggregate(origine~prenom, data = prenoms, paste0, collapse=" ")

  # supprimer les virgules dans la colonne origine
  prenoms$origine  <- stringr::str_replace_all(prenoms$origine, ",", " ")

return (prenoms)

}



