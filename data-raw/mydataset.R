## code to prepare `mydataset` dataset goes here


# Set up the data-raw directory and data processing script
# You can use any name you want (nom de ce fichier)
usethis::use_data_raw(name = 'mydataset')

# This script in the R directory will contain the documentation.
# You can use any name you want.
file.create("R/data.R")
# Pour charger les fichiers:
# load("data/nat2018_fichier_initial.rda")
# load("data/prenoms_fichier_initial.rda")



# data-raw/mydataset.R
# Data import and processing pipeline

nat2018_fichier_initial <- read.csv("data-raw/nat2018.csv", sep=";", encoding = "UTF-8")
prenoms_fichier_initial <- read.csv("data-raw/Prenoms.csv", sep=";")

usethis::use_data(nat2018_fichier_initial, prenoms_fichier_initial, overwrite = T)


