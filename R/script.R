#
#
#
# ####-------------- Import données -----------------------------------------------------------
# load("data/nat2018_fichier_initial.rda")
# load("data/prenoms_fichier_initial.rda")
#
#
#
# ####-------------- Traitements base prenoms behind the name ------------------------------------
# prenoms <- prenoms_fichier_initial %>%  dplyr::rename(prenom=X01_prenom, origine=X03_langage) %>% dplyr::select(prenom, origine)
#
# #mettre les prenoms en majuscule
# prenoms$prenom <- stringr::str_to_upper(prenoms$prenom)
#
# # enlever les accents aux prenoms
# prenoms$prenom <- iconv(as.character(prenoms$prenom),from="UTF-8",  to="ASCII//TRANSLIT")
# prenoms$prenom <- gsub("'", '', prenoms$prenom)
#
# # supprimer les (1), (2), etc en cas de plusieurs lignes pour un même prenom
# prenoms$prenom <-  stringr::str_extract(prenoms$prenom,"^[A-Z]+" )
#
# # supprimer les lignes NA 'caracteres non existants en France'
# prenoms <-prenoms[!(is.na(prenoms$prenom)),]
#
# # grouper les lignes qui concernent les mêmes prenoms
# prenoms <- aggregate(origine~prenom, data = prenoms, paste0, collapse=" ")
#
# # supprimer les virgules dans la colonne origine
# prenoms$origine  <- stringr::str_replace_all(prenoms$origine, ",", " ")
#
# unique(prenoms$origine) #816 origines differentes
#
# save(prenoms, file="data/prenoms.RData")
# load("data/prenoms.RData") # import prenoms
#
#
#
#
# # ####---------------Traitements stats prenoms insee -----------------------------------------------
# library(dplyr)
# nat2018 <- nat2018_fichier_initial %>% rename(prenom=preusuel, sexe=X.U.FEFF.sexe)
#
# # enlever les accents aux prenoms (comme dans la base des prenoms)
# nat2018$prenom <- iconv(as.character(nat2018$prenom), from="UTF-8", to="ASCII//TRANSLIT")
#
#
#
#
# # ####---------------Traitements base fusionnée des prenoms------------------------------------------
# #base <- nat2018 %>%  left_join(prenoms, by="prenom")
# #base_2018 <- filter(base, annais=="2018")
#
# # base_ordonnee <- arrange(base, desc(nombre))
# base_ordonnee_na <- base_ordonnee[is.na(base_ordonnee$origine),]
# base_ordonnee_na <-filter(base_ordonnee_na, prenom != "_PRENOMS_RARES")
#
# # il reste 9465 prenoms sans origine en 2018
# save(base, file="data/base.RData")
#
#
#
# # ajout des origines manquantes à certains prenoms
# base$origine = if_else(base$prenom=="MAEL", "french", base$origine)
# base$origine = if_else(base$prenom=="GABIN", "french", base$origine)
# base$origine = if_else(base$prenom=="TIMEO", "spanish italian", base$origine)
# base$origine = if_else(base$prenom=="KARINE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-PIERRE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-CLAUDE", "french", base$origine)
# base$origine = if_else(base$prenom=="EVELYNE", "french", base$origine)
# base$origine = if_else(base$prenom=="JOCELYNE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-LUC", "french", base$origine)
# base$origine = if_else(base$prenom=="MICKAEL", "french swedish", base$origine)
# base$origine = if_else(base$prenom=="LILIANE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-CHRISTINE", "french", base$origine)
# base$origine = if_else(base$prenom=="	JEAN-MARC", "french", base$origine)
# base$origine = if_else(base$prenom=="MARYSE", "french", base$origine)
# base$origine = if_else(base$prenom=="MATHEO", "norwegian swedish", base$origine)
# base$origine = if_else(base$prenom=="YANIS", "french greek", base$origine)
# base$origine = if_else(base$prenom=="HUGUETTE", "french", base$origine)
# base$origine = if_else(base$prenom=="MAGALI", "french", base$origine)
# base$origine = if_else(base$prenom=="FLORENT", "french", base$origine)
# base$origine = if_else(base$prenom=="ANNE-MARIE", "french", base$origine)
# base$origine = if_else(base$prenom=="OPHELIE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-MICHEL", "french", base$origine)
# base$origine = if_else(base$prenom=="LILOU", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-THERESE", "french", base$origine)
# base$origine = if_else(base$prenom=="JACKY", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-LOUIS", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-FRANCOIS", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-MARIE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-PAUL", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-CLAUDE", "french", base$origine)
# base$origine = if_else(base$prenom=="MAELYS", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-MARC", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-FRANCE", "french", base$origine)
# base$origine = if_else(base$prenom=="LOUNA", "french", base$origine)
# base$origine = if_else(base$prenom=="PIERRETTE", "french", base$origine)
# base$origine = if_else(base$prenom=="MAXENCE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-JACQUES", "french", base$origine)
# base$origine = if_else(base$prenom=="LUCETTE", "french", base$origine)
# base$origine = if_else(base$prenom=="GAELLE", "french breton english", base$origine)
# base$origine = if_else(base$prenom=="VIVIANE", "french", base$origine)
# base$origine = if_else(base$prenom=="MEGANE", "french", base$origine)
# base$origine = if_else(base$prenom=="MURIELLE", "french", base$origine)
# base$origine = if_else(base$prenom=="NADEGE", "french", base$origine)
# base$origine = if_else(base$prenom=="KATIA", "italian russian bulgarian ukrainian", base$origine)
# base$origine = if_else(base$prenom=="YOANN", "french", base$origine)
# base$origine = if_else(base$prenom=="RAYAN", "arabic", base$origine)
# base$origine = if_else(base$prenom=="CHRISTEL", "french", base$origine)
# base$origine = if_else(base$prenom=="MARYLINE", "french", base$origine)
# base$origine = if_else(base$prenom=="KYLIAN", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-PHILIPPE", "french", base$origine)
# base$origine = if_else(base$prenom=="MATHYS", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-JOSE", "french", base$origine)
# base$origine = if_else(base$prenom=="LUDIVINE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-CHRISTOPHE", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-HELENE", "french", base$origine)
# base$origine = if_else(base$prenom=="MAURICETTE", "french", base$origine)
# base$origine = if_else(base$prenom=="NATACHA", "french portuguese", base$origine)
# base$origine = if_else(base$prenom=="EMILIENNE", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-LAURE", "french", base$origine)
# base$origine = if_else(base$prenom=="INAYA", "urdu bengali", base$origine)
# base$origine = if_else(base$prenom=="ANNE-SOPHIE", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-YVES", "french", base$origine)
# base$origine = if_else(base$prenom=="MAGALIE", "french", base$origine)
# base$origine = if_else(base$prenom=="MEHDI", "persian arabic", base$origine)
# base$origine = if_else(base$prenom=="SOLENE", "french", base$origine)
# base$origine = if_else(base$prenom=="LOUANE", "french", base$origine)
# base$origine = if_else(base$prenom=="TITOUAN", "french", base$origine)
# base$origine = if_else(base$prenom=="JEAN-BAPTISTE", "french", base$origine)
# base$origine = if_else(base$prenom=="THIBAUT", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-FRANCOISE", "french", base$origine)
# base$origine = if_else(base$prenom=="LEANA", "english", base$origine)
# base$origine = if_else(base$prenom=="AMINE", "arabic", base$origine)
# base$origine = if_else(base$prenom=="ANTONIN", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-LINE", "french", base$origine)
# base$origine = if_else(base$prenom=="LYAM", "french", base$origine)
# base$origine = if_else(base$prenom=="MALO", "breton", base$origine)
# base$origine = if_else(base$prenom=="MARIE-PIERRE", "french", base$origine)
# base$origine = if_else(base$prenom=="MAELLE", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-CLAIRE", "french", base$origine)
# base$origine = if_else(base$prenom=="NAEL", "french", base$origine)
# base$origine = if_else(base$prenom=="CHRISTELE", "french", base$origine)
# base$origine = if_else(base$prenom=="LEANE", "french", base$origine)
# base$origine = if_else(base$prenom=="MARIE-LOUISE", "french", base$origine)
# base$origine = if_else(base$prenom=="KENZA", "arabic", base$origine)
# base$origine = if_else(base$prenom=="MYLENE", "french", base$origine)
# base$origine = if_else(base$prenom=="CAPUCINE", "french", base$origine)
# base$origine = if_else(base$prenom=="TANGUY", "french breton", base$origine)
# base$origine = if_else(base$prenom=="MARCEAU", "french", base$origine)
# base$origine = if_else(base$prenom=="ENORA", "french breton", base$origine)
# base$origine = if_else(base$prenom=="JORDY", "english", base$origine)
# base$origine = if_else(base$prenom=="ALIZEE", "french english", base$origine)
# base$origine = if_else(base$prenom=="ILYES", "arabic", base$origine)
# base$origine = if_else(base$prenom=="ANAELLE", "french", base$origine)
# base$origine = if_else(base$prenom=="IMRAN", "arabic", base$origine)
# base$origine = if_else(base$prenom=="AYDEN", "english", base$origine)
# base$origine = if_else(base$prenom=="NOUR", "arabic", base$origine)
# base$origine = if_else(base$prenom=="YOHANN", "french", base$origine)
# base$origine = if_else(base$prenom=="KAIS", "arabic", base$origine)
# base$origine = if_else(base$prenom=="FLORIANE", "french", base$origine)
# base$origine = if_else(base$prenom=="ROSELYNE", "french", base$origine)
# base$origine = if_else(base$prenom=="LOUKA", "french", base$origine)
# base$origine = if_else(base$prenom=="SOHAN", "french", base$origine)
# base$origine = if_else(base$prenom=="COME", "french", base$origine)
# base$origine = if_else(base$prenom=="ASSIA", "arabic", base$origine)
# base$origine = if_else(base$prenom=="ANNE-LAURE", "french", base$origine)
# base$origine = if_else(base$prenom=="LIA", "italian portuguese georgian greek dutch", base$origine)
# base$origine = if_else(base$prenom=="YOHAN", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
# base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
#
# ####---------------Stats base fusionnée des prenoms------------------------------------------
# # test pour filtrer tous les prenoms selon une origine donnée
# library(stringr)
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
# afr =base_2018 %>% filter(str_detect(origine,"african"))
# afr %>%  group_by(annais) %>%  summarise(sum(nombre))
#
# base_ordonnee_na %>%  summarise(sum(nombre))
#
#
#
#
#
