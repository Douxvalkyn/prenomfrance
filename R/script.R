#
# library(dplyr)
# library(outils)

#   devtools::check()

# ####-------------- SAVE -----------------------------------------------------------
# save(base_nat,file= "data/base_nat.rda") #base nationale
# save(base_dep,file= "data/base_dep.rda") #base dep
# save(table_nat,file= "data/table_nat.rda") #taux nationaux
# save(table_dep,file= "data/table_dep.rda") #taux dep
#save(prenoms_fichier_initial, file="data/prenoms_fichier_initial.rda")


# ####----------- LOAD DATA -------------------------------------------------------------
# load("data/dpt2018_fichier_initial.rda")
# load("data/nat2018_fichier_initial.rda")
# load("data/prenoms_fichier_initial.rda")

# load("data/table_dep.rda") #taux dep
# load("data/table_nat.rda") #taux nat
# load("data/base_dep.rda") #base complete dep
# load("data/base_nat.rda") #base complete nat
# load("data/map_dep.rda") #map




# ####----------- SCRIPT de calculs -------------------------------------------------------------
#
# Encoding(levels(prenoms_fichier_initial$X01_prenom)) <- "latin1"
# levels(prenoms_fichier_initial$X01_prenom) <- iconv(
#   levels(prenoms_fichier_initial$X01_prenom),
#   "latin1",
#   "UTF-8"
# )






