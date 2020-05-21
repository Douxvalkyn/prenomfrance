library(dplyr)
library(stringr)
library(outils)

####-------------- Import données -----------------------------------------------------------

# load from rdata ou dans Z !
# load(system.file("data","prenoms.RData", package = "prenomfrance")) # import prenoms
#

#
# ####-------------- Traitements base prenoms behind the name ------------------------------------
# prenoms <- prenoms %>%  rename(prenom=X01_prenom, origine=X03_langage) %>% select(prenom, origine)
# prenoms$prenom <- str_to_upper(prenoms$prenom)
#
#
# # supprimer les (1), (2), etc en cas de plusieurs lignes pour un même prenom
# prenoms$prenom <-   str_extract(prenoms$prenom,"^[A-Z]+" )
#
# # grouper les lignes qui concernent les mêmes prenoms
# prenoms2 <- prenoms %>% group_by(prenom) %>%   mutate(origine2 = paste0(origine, collapse = ""))
# prenoms3 <- aggregate(origine~prenom, data = prenoms2, paste0, collapse=" ")
#
# # supprimer les virgules dans la colonne origine
# prenoms3$origine  <- str_replace_all(prenoms3$origine, ",", " ")
#
# unique(prenoms3$origine) #821 origines differentes
#
# # ajouter une origine à la base
# save(prenoms, file="data/prenoms.RData")
# load(system.file("data","prenoms.Rdata", package = "prenomfrance")) # import prenoms
#
#
#
#
# ####---------------Traitements stats prenoms insee -----------------------------------------------
# nat2018 <- nat2018 %>%rename(prenom=preusuel, sexe=X.U.FEFF.sexe)
#
# # enlever les accents aux prenoms (comme dans la base des prenoms)
# nat2018$prenom <- iconv(as.character(nat2018$prenom), from="UTF-8", to="ASCII//TRANSLIT")
#
#
#
#
# ####---------------Traitements base fusionnée des prenoms------------------------------------------
# base <- nat2018 %>%  left_join(prenoms, by="prenom")
# base_2018 <- filter(base, annais=="2018")
#
# base_ordonnee <- arrange(base_2018, desc(nombre))
# base_ordonnee_na <- base_ordonnee[is.na(base_ordonnee$origine),]
#
# # il reste 9465 prenoms sans origine
#
#
#
#
# ####---------------Stats base fusionnée des prenoms------------------------------------------
# # test pour filtrer tous les prenoms selon une origine donnée
# fr =base_2018 %>% filter(str_detect(origine,"french"))
# fr %>%  group_by(annais) %>%  summarise(sum(nombre))
#
# base_2018 %>%  group_by(origine) %>%  summarise(tot=sum(nombre)) %>%  arrange(desc(tot))
#
# eng =base_2018 %>% filter(str_detect(origine,"english"))
# eng %>%  group_by(annais) %>%  summarise(sum(nombre))
#
# arab =base_2018 %>% filter(str_detect(origine,"arabic"))
# arab %>%  group_by(annais) %>%  summarise(sum(nombre))
#
# ita =base_2018 %>% filter(str_detect(origine,"italian"))
# ita %>%  group_by(annais) %>%  summarise(sum(nombre))
#
# base_ordonnee_na %>%  summarise(sum(nombre))





