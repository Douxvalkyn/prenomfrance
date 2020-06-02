
#' mise en forme du fichier insee national ou departemental des prenoms
#'
#' @param fichier_insee fichier national ou departemental insee des prenoms
#'
#' @return dataframe mis en forme pour jointure avec base mondiale des prenoms
#'

mise_forme_fichier_insee = function (fichier_insee){

  #renommage colonne SEXE (bug lors de l'import du csv)
  fichier_insee <- fichier_insee %>% dplyr::rename(prenom=preusuel, sexe=X.U.FEFF.sexe)

  # enlever les accents aux prenoms (comme dans la base des prenoms)
  fichier_insee$prenom <- iconv(as.character(fichier_insee$prenom), from="UTF-8", to="ASCII//TRANSLIT")


  return (fichier_insee)
}



