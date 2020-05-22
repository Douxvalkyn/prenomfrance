


####-------------- Import données -----------------------------------------------------------
load("data/nat2018_fichier_initial.rda")
load("data/prenoms_fichier_initial.rda")



####-------------- Traitements base prenoms behind the name ------------------------------------
prenoms <- prenoms_fichier_initial %>%  dplyr::rename(prenom=X01_prenom, origine=X03_langage) %>% dplyr::select(prenom, origine)

#mettre les prenoms en majuscule
prenoms$prenom <- stringr::str_to_upper(prenoms$prenom)

# enlever les accents aux prenoms
prenoms$prenom <- iconv(as.character(prenoms$prenom),from="UTF-8",  to="ASCII//TRANSLIT")
prenoms$prenom <- gsub("'", '', prenoms$prenom)

# supprimer les (1), (2), etc en cas de plusieurs lignes pour un même prenom
prenoms$prenom <-  stringr::str_extract(prenoms$prenom,"^[A-Z]+" )

# supprimer les lignes NA 'caracteres non existants en France'
prenoms <-prenoms[!(is.na(prenoms$prenom)),]

# grouper les lignes qui concernent les mêmes prenoms
prenoms <- aggregate(origine~prenom, data = prenoms, paste0, collapse=" ")

# supprimer les virgules dans la colonne origine
prenoms$origine  <- stringr::str_replace_all(prenoms$origine, ",", " ")

unique(prenoms$origine) #816 origines differentes

save(prenoms, file="data/prenoms.RData")
load("data/prenoms.RData") # import prenoms




# ####---------------Traitements stats prenoms insee -----------------------------------------------
library(dplyr)
nat2018 <- nat2018_fichier_initial %>% rename(prenom=preusuel, sexe=X.U.FEFF.sexe)

# enlever les accents aux prenoms (comme dans la base des prenoms)
nat2018$prenom <- iconv(as.character(nat2018$prenom), from="UTF-8", to="ASCII//TRANSLIT")




# ####---------------Traitements base fusionnée des prenoms------------------------------------------
#base <- nat2018 %>%  left_join(prenoms, by="prenom")


#####-------------------------- Import fichier base -----------------------------------------------
save(base, file="data/base.RData")
load("data/base.rda")

#base_2018 <- filter(base, annais=="2018")

base_ordonnee <- arrange(base, desc(nombre))
base_ordonnee_na <- base_ordonnee[is.na(base_ordonnee$origine),]
base_ordonnee_na <-filter(base_ordonnee_na, prenom != "_PRENOMS_RARES")




## calcul du taux de prenoms tagés selon l'origine 39.5%
nb_prenoms <- dim(base)[1]
nb_prenoms_na <- dim(base[is.na(base$origine),])[1]
1 - (nb_prenoms_na/nb_prenoms)

## calcul du taux de bébés tagés selon l'origine 91.1 %
nb_bebes <- base %>%   summarise(sum(nombre))
nb_bebes_na <- base[is.na(base$origine),] %>%   summarise(sum(nombre))
1 - (nb_bebes_na/nb_bebes)

# ajout des origines manquantes à certains prenoms
base$origine = if_else(base$prenom=="MAEL", "french", base$origine)
base$origine = if_else(base$prenom=="GABIN", "french", base$origine)
base$origine = if_else(base$prenom=="TIMEO", "spanish italian", base$origine)
base$origine = if_else(base$prenom=="KARINE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-PIERRE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-CLAUDE", "french", base$origine)
base$origine = if_else(base$prenom=="EVELYNE", "french", base$origine)
base$origine = if_else(base$prenom=="JOCELYNE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-LUC", "french", base$origine)
base$origine = if_else(base$prenom=="MICKAEL", "french swedish", base$origine)
base$origine = if_else(base$prenom=="LILIANE", "french", base$origine)
base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-CHRISTINE", "french", base$origine)
base$origine = if_else(base$prenom=="	JEAN-MARC", "french", base$origine)
base$origine = if_else(base$prenom=="MARYSE", "french", base$origine)
base$origine = if_else(base$prenom=="MATHEO", "norwegian swedish", base$origine)
base$origine = if_else(base$prenom=="YANIS", "french greek", base$origine)
base$origine = if_else(base$prenom=="HUGUETTE", "french", base$origine)
base$origine = if_else(base$prenom=="MAGALI", "french", base$origine)
base$origine = if_else(base$prenom=="FLORENT", "french", base$origine)
base$origine = if_else(base$prenom=="ANNE-MARIE", "french", base$origine)
base$origine = if_else(base$prenom=="OPHELIE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-MICHEL", "french", base$origine)
base$origine = if_else(base$prenom=="LILOU", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-THERESE", "french", base$origine)
base$origine = if_else(base$prenom=="JACKY", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-LOUIS", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-FRANCOIS", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-MARIE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-PAUL", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-CLAUDE", "french", base$origine)
base$origine = if_else(base$prenom=="MAELYS", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-MARC", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-FRANCE", "french", base$origine)
base$origine = if_else(base$prenom=="LOUNA", "french", base$origine)
base$origine = if_else(base$prenom=="PIERRETTE", "french", base$origine)
base$origine = if_else(base$prenom=="MAXENCE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-JACQUES", "french", base$origine)
base$origine = if_else(base$prenom=="LUCETTE", "french", base$origine)
base$origine = if_else(base$prenom=="GAELLE", "french breton english", base$origine)
base$origine = if_else(base$prenom=="VIVIANE", "french", base$origine)
base$origine = if_else(base$prenom=="MEGANE", "french", base$origine)
base$origine = if_else(base$prenom=="MURIELLE", "french", base$origine)
base$origine = if_else(base$prenom=="NADEGE", "french", base$origine)
base$origine = if_else(base$prenom=="KATIA", "italian russian bulgarian ukrainian", base$origine)
base$origine = if_else(base$prenom=="YOANN", "french", base$origine)
base$origine = if_else(base$prenom=="RAYAN", "arabic", base$origine)
base$origine = if_else(base$prenom=="CHRISTEL", "french", base$origine)
base$origine = if_else(base$prenom=="MARYLINE", "french", base$origine)
base$origine = if_else(base$prenom=="KYLIAN", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-PHILIPPE", "french", base$origine)
base$origine = if_else(base$prenom=="MATHYS", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-JOSE", "french", base$origine)
base$origine = if_else(base$prenom=="LUDIVINE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-CHRISTOPHE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-HELENE", "french", base$origine)
base$origine = if_else(base$prenom=="MAURICETTE", "french", base$origine)
base$origine = if_else(base$prenom=="NATACHA", "french portuguese", base$origine)
base$origine = if_else(base$prenom=="EMILIENNE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-LAURE", "french", base$origine)
base$origine = if_else(base$prenom=="INAYA", "urdu bengali", base$origine)
base$origine = if_else(base$prenom=="ANNE-SOPHIE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-YVES", "french", base$origine)
base$origine = if_else(base$prenom=="MAGALIE", "french", base$origine)
base$origine = if_else(base$prenom=="MEHDI", "persian arabic", base$origine)
base$origine = if_else(base$prenom=="SOLENE", "french", base$origine)
base$origine = if_else(base$prenom=="LOUANE", "french", base$origine)
base$origine = if_else(base$prenom=="TITOUAN", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-BAPTISTE", "french", base$origine)
base$origine = if_else(base$prenom=="THIBAUT", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-FRANCOISE", "french", base$origine)
base$origine = if_else(base$prenom=="LEANA", "english", base$origine)
base$origine = if_else(base$prenom=="AMINE", "arabic", base$origine)
base$origine = if_else(base$prenom=="ANTONIN", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-LINE", "french", base$origine)
base$origine = if_else(base$prenom=="LYAM", "french", base$origine)
base$origine = if_else(base$prenom=="MALO", "breton", base$origine)
base$origine = if_else(base$prenom=="MARIE-PIERRE", "french", base$origine)
base$origine = if_else(base$prenom=="MAELLE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-CLAIRE", "french", base$origine)
base$origine = if_else(base$prenom=="NAEL", "french", base$origine)
base$origine = if_else(base$prenom=="CHRISTELE", "french", base$origine)
base$origine = if_else(base$prenom=="LEANE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-LOUISE", "french", base$origine)
base$origine = if_else(base$prenom=="KENZA", "arabic", base$origine)
base$origine = if_else(base$prenom=="MYLENE", "french", base$origine)
base$origine = if_else(base$prenom=="CAPUCINE", "french", base$origine)
base$origine = if_else(base$prenom=="TANGUY", "french breton", base$origine)
base$origine = if_else(base$prenom=="MARCEAU", "french", base$origine)
base$origine = if_else(base$prenom=="ENORA", "french breton", base$origine)
base$origine = if_else(base$prenom=="JORDY", "english", base$origine)
base$origine = if_else(base$prenom=="ALIZEE", "french english", base$origine)
base$origine = if_else(base$prenom=="ILYES", "arabic", base$origine)
base$origine = if_else(base$prenom=="ANAELLE", "french", base$origine)
base$origine = if_else(base$prenom=="IMRAN", "arabic", base$origine)
base$origine = if_else(base$prenom=="AYDEN", "english", base$origine)
base$origine = if_else(base$prenom=="NOUR", "arabic", base$origine)
base$origine = if_else(base$prenom=="YOHANN", "french", base$origine)
base$origine = if_else(base$prenom=="KAIS", "arabic", base$origine)
base$origine = if_else(base$prenom=="FLORIANE", "french", base$origine)
base$origine = if_else(base$prenom=="ROSELYNE", "french", base$origine)
base$origine = if_else(base$prenom=="LOUKA", "french", base$origine)
base$origine = if_else(base$prenom=="SOHAN", "french", base$origine)
base$origine = if_else(base$prenom=="COME", "french", base$origine)
base$origine = if_else(base$prenom=="ASSIA", "arabic", base$origine)
base$origine = if_else(base$prenom=="ANNE-LAURE", "french", base$origine)
base$origine = if_else(base$prenom=="LIA", "italian portuguese georgian greek dutch", base$origine)
base$origine = if_else(base$prenom=="YOHAN", "french", base$origine)
base$origine = if_else(base$prenom=="ROMANE", "french", base$origine)
base$origine = if_else(base$prenom=="EMY", "french", base$origine)
base$origine = if_else(base$prenom=="LYANA", "french", base$origine)
base$origine = if_else(base$prenom=="ILYAN", "french", base$origine)
base$origine = if_else(base$prenom=="AYOUB", "persian arabic", base$origine)
base$origine = if_else(base$prenom=="ZELIE", "french", base$origine)
base$origine = if_else(base$prenom=="NOHAM", "french", base$origine)
base$origine = if_else(base$prenom=="KENZO", "french japanese", base$origine)
base$origine = if_else(base$prenom=="SOLINE", "french", base$origine)
base$origine = if_else(base$prenom=="ELIO", "italian", base$origine)
base$origine = if_else(base$prenom=="CHARLY", "french", base$origine)
base$origine = if_else(base$prenom=="MAHE", "breton", base$origine)
base$origine = if_else(base$prenom=="YOUNES", "arabic persian", base$origine)
base$origine = if_else(base$prenom=="AYMEN", "arabic", base$origine)
base$origine = if_else(base$prenom=="ILYANA", "romanian spanish italian", base$origine)
base$origine = if_else(base$prenom=="MAISSA", "provencal", base$origine)
base$origine = if_else(base$prenom=="NAHIL", "arabic", base$origine)
base$origine = if_else(base$prenom=="GARANCE", "french", base$origine)
base$origine = if_else(base$prenom=="TIMOTHE", "french", base$origine)
base$origine = if_else(base$prenom=="LISON", "french", base$origine)
base$origine = if_else(base$prenom=="MYLA", "english", base$origine)
base$origine = if_else(base$prenom=="ZAKARIA", "georgian arabic", base$origine)
base$origine = if_else(base$prenom=="NASSIM", "arabic", base$origine)
base$origine = if_else(base$prenom=="YASSINE", "arabic", base$origine)
base$origine = if_else(base$prenom=="EMNA", "arabic", base$origine)
base$origine = if_else(base$prenom=="LYA", "french", base$origine)
base$origine = if_else(base$prenom=="YOHAN", "french", base$origine)
base$origine = if_else(base$prenom=="SOFIANE", "arabic", base$origine)
base$origine = if_else(base$prenom=="LOANE", "french", base$origine)
base$origine = if_else(base$prenom=="EMY", "french", base$origine)
base$origine = if_else(base$prenom=="CHRYSTELLE", "french", base$origine)
base$origine = if_else(base$prenom=="KENZO", "french japanese", base$origine)
base$origine = if_else(base$prenom=="AYOUB", "persian arabic", base$origine)
base$origine = if_else(base$prenom=="ROMUALD", "german dutch polish", base$origine)
base$origine = if_else(base$prenom=="LYNA", "french", base$origine)
base$origine = if_else(base$prenom=="GAEL", "english", base$origine)
base$origine = if_else(base$prenom=="MARYLENE", "french", base$origine)
base$origine = if_else(base$prenom=="MELODIE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-PAULE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-NOELLE", "french", base$origine)
base$origine = if_else(base$prenom=="NOHAM", "french", base$origine)
base$origine = if_else(base$prenom=="CLOE", "french", base$origine)
base$origine = if_else(base$prenom=="SOAN", "french", base$origine)
base$origine = if_else(base$prenom=="MARTIAL", "french", base$origine)
base$origine = if_else(base$prenom=="ELIE", "jewish", base$origine)
base$origine = if_else(base$prenom=="CLAUDIE", "french", base$origine)
base$origine = if_else(base$prenom=="NOLWENN", "breton", base$origine)
base$origine = if_else(base$prenom=="AYMERIC", "french", base$origine)
base$origine = if_else(base$prenom=="YOUNES", "arabic persian", base$origine)
base$origine = if_else(base$prenom=="MELINE", "french", base$origine)
base$origine = if_else(base$prenom=="MAISSA", "provencal", base$origine)
base$origine = if_else(base$prenom=="TIPHAINE", "french", base$origine)
base$origine = if_else(base$prenom=="YVAN", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-JEANNE", "french", base$origine)
base$origine = if_else(base$prenom=="SYLVETTE", "french", base$origine)
base$origine = if_else(base$prenom=="ZELIE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-PAULE", "french", base$origine)
base$origine = if_else(base$prenom=="BILAL", "arabic", base$origine)
base$origine = if_else(base$prenom=="JESSY", "french dutch english", base$origine)
base$origine = if_else(base$prenom=="ROSELINE", "french", base$origine)
base$origine = if_else(base$prenom=="LYLOU", "italian", base$origine)
base$origine = if_else(base$prenom=="ELIO", "french", base$origine)
base$origine = if_else(base$prenom=="MAHE", "breton", base$origine)
base$origine = if_else(base$prenom=="LOAN", "french", base$origine)
base$origine = if_else(base$prenom=="NAHIL", "arabic", base$origine)
base$origine = if_else(base$prenom=="MARINETTE", "french", base$origine)
base$origine = if_else(base$prenom=="KYLLIAN", "french irish", base$origine)
base$origine = if_else(base$prenom=="RACHID", "arabic", base$origine)
base$origine = if_else(base$prenom=="NOLHAN", "french", base$origine)
base$origine = if_else(base$prenom=="NICOLLE", "french", base$origine)
base$origine = if_else(base$prenom=="LOU-ANNE", "french", base$origine)
base$origine = if_else(base$prenom=="YVELINE", "french", base$origine)
base$origine = if_else(base$prenom=="CYRIELLE", "french", base$origine)
base$origine = if_else(base$prenom=="LOUISETTE", "french", base$origine)
base$origine = if_else(base$prenom=="ANNY", "french", base$origine)
base$origine = if_else(base$prenom=="BLANDINE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-ANGE", "french", base$origine)
base$origine = if_else(base$prenom=="ANISSA", "english", base$origine)
base$origine = if_else(base$prenom=="MAILYS", "french", base$origine)
base$origine = if_else(base$prenom=="THIBAUD", "french", base$origine)
base$origine = if_else(base$prenom=="YOAN", "french", base$origine)
base$origine = if_else(base$prenom=="LAURYNE", "french", base$origine)
base$origine = if_else(base$prenom=="RAYANE", "arabic", base$origine)
base$origine = if_else(base$prenom=="LOU-ANN", "french", base$origine)
base$origine = if_else(base$prenom=="CHRYSTELE", "french", base$origine)
base$origine = if_else(base$prenom=="NOLANN", "french", base$origine)
base$origine = if_else(base$prenom=="CLOTILDE", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-NOEL", "french", base$origine)
base$origine = if_else(base$prenom=="GAUTHIER", "french", base$origine)
base$origine = if_else(base$prenom=="JEAN-CHARLES", "french", base$origine)
base$origine = if_else(base$prenom=="SAMY", "french", base$origine)
base$origine = if_else(base$prenom=="ELOUAN", "french", base$origine)
base$origine = if_else(base$prenom=="LAURIANE", "french", base$origine)
base$origine = if_else(base$prenom=="MARIE-ODILE", "french", base$origine)
base$origine = if_else(base$prenom=="STEEVE", "french", base$origine)
base$origine = if_else(base$prenom=="MALLAURY", "french", base$origine)
base$origine = if_else(base$prenom=="PRISCILLIA", "french", base$origine)
base$origine = if_else(base$prenom=="LENY", "french", base$origine)
base$origine = if_else(base$prenom=="PHILOMENE", "french", base$origine)
base$origine = if_else(base$prenom=="MATIS", "french", base$origine)
base$origine = if_else(base$prenom=="CLEA", "french english german", base$origine)
base$origine = if_else(base$prenom=="YACINE", "arabic", base$origine)
base$origine = if_else(base$prenom=="MARIE-MADELEINE", "french", base$origine)
base$origine = if_else(base$prenom=="ORLANE", "french", base$origine)
base$origine = if_else(base$prenom=="LENY", "french", base$origine)
base$origine = if_else(base$prenom=="JOFFREY", "french", base$origine)
base$origine = if_else(base$prenom=="LALY", "french", base$origine)
base$origine = if_else(base$prenom=="TEO", "italian spanish croatian", base$origine)
base$origine = if_else(base$prenom=="DALILA", "french italian spanish portuguese", base$origine)
base$origine = if_else(base$prenom=="IMANE", "arabic", base$origine)
base$origine = if_else(base$prenom=="SIRINE", "french", base$origine)
base$origine = if_else(base$prenom=="NATHAEL", "french", base$origine)
base$origine = if_else(base$prenom=="CHAIMA", "arabic", base$origine)
base$origine = if_else(base$prenom=="CASSANDRE", "french", base$origine)
base$origine = if_else(base$prenom=="LYSIANE", "french", base$origine)
base$origine = if_else(base$prenom=="AMEL", "arabic", base$origine)
base$origine = if_else(base$prenom=="FLAVIEN", "french", base$origine)
base$origine = if_else(base$prenom=="ALIYA", "arabic", base$origine)
base$origine = if_else(base$prenom=="MARIE-JOSEPHE", "french", base$origine)
base$origine = if_else(base$prenom=="KAMEL", "arabic", base$origine)
base$origine = if_else(base$prenom=="SAMIA", "french", base$origine)
base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)
base$origine = if_else(base$prenom=="SIMONNE", "french", base$origine)

####---------------Stats base fusionnée des prenoms------------------------------------------
# test pour filtrer tous les prenoms selon une origine donnée
library(stringr)


# 87 origines differentes
origines <- unique(na.omit(unlist(str_split(base$origine, ' '))))
# nettoyage
origines <- origines[origines!=""]
origines <- origines[origines!="(latinized)"]
origines <- origines[origines!="ancient"]
origines <- origines[origines!="history"]
origines <- origines[origines!="literature"]
origines <- origines[origines!="(variant)"]
origines <- origines[origines!="legend"]
origines <- origines[origines!="(modern)"]
origines <- origines[origines!="(hellenized)"]
origines <- origines[origines!="(anglicized)"]
origines <- origines[origines!="astronomy"]
origines <- origines[origines!="near"]
# 75 origines distinctes



# annees
annees <- unique(as.vector(base$annais))
annees <- annees[annees!="XXXX"]
annees <- as.numeric(annees)
annees <- sort(annees)



# on initialise df avec la bonne structure
df=origines
for (annee in annees){

  i=1
  taux=NULL
for (ethnie in origines){
base_an <- filter(base, annais==annee)
nb_prenoms_an <- base_an %>%  group_by(annais) %>%  summarise(sum(nombre)) %>%  unlist()
base_an_ethnie <- base_an %>% filter(str_detect(origine,ethnie))
if (dim(base_an_ethnie)[1]>0){
tx <-  base_an_ethnie %>%  group_by(annais) %>%  summarise(sum(100*nombre/nb_prenoms_an[2]))
taux[i] <- unlist(tx[2])
}
if (dim(base_an_ethnie)[1]==0){ taux[i]<-0}

i=i+1
}

result <-taux
result<- as.data.frame(result)
df<- cbind(df, result)

}


df_t <- t(df) %>%  as.data.frame()
colnames(df_t) <- origines
# supprimer la ligne 1 qui ne sert plus
df_t = df_t[-1,]
df_t <- mutate(df_t, annee=annees)
df_t <- df_t %>% select(annee, everything())


plot(df_t$annee, as.numeric(as.vector(df_t$scandinavian)))


# faire une liste des prenoms par origine et par annee et par sexe
top <-filter(base, origine=="french" & annais=="2018" & sexe %in% c(1,2)) %>%
  arrange(desc(nombre))
