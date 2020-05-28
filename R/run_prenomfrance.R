#' run_prenomfrance
#' Fonction qui permet de lancer l'app shiny
#'
#' @return lance l'app shiny
#' @export
#'

run_prenomfrance <- function() {
  appDir <- system.file("shiny", package = "prenomfrance")
  if (appDir == "") {
    stop("Could not find directory. Try re-installing `prenomfrance`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}


# data(package="prenomfrance")
# library(prenomfrance)
# run_prenomfrance()






