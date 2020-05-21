library(dplyr)
library(stringr)
# save(mydata, file="data/mydata.RData")

nat2018 <- read.csv("C:/Users/YFAWC1/Documents/prenomfrance/data/nat2018.csv", sep=";", encoding = "UTF-8")
prenoms <- read.csv("C:/Users/YFAWC1/Documents/prenomfrance/data/Prenoms.csv", sep=";")

nat2018 <- nat2018 %>%rename(prenom=preusuel, sexe=X.U.FEFF.sexe)
prenoms <- prenoms %>%  rename(prenom=X01_prenom, origine=X03_langage) %>% select(prenom, origine)
prenoms$prenom <- str_to_upper(prenoms$prenom)


base <- nat2018 %>%  left_join(prenoms, by="prenom")
base_2018 <- filter(base, annais=="2018")

base_ordonnee <- arrange(base_2018, desc(nombre))
base_ordonnee_na <- base_ordonnee[is.na(base_ordonnee$origine),]

# il reste 9938 prenoms sans origine
# supprimons les accents
b=as.character(base_ordonnee_na$prenom)
iconv(b, from="UTF-8", to="ASCII//TRANSLIT")
base_ordonnee_na$prenom <- iconv(b, from="UTF-8", to="ASCII//TRANSLIT")

base_ordonnee_na2 <- select(base_ordonnee_na, -origine) %>%  left_join(prenoms, by="prenom")
base_ordonnee_na3 <- base_ordonnee_na2[is.na(base_ordonnee_na2$origine),]



v1=c("JULES (1)", "AZer")
v1[!grepl("^[A-Z]$", v1)]

# fonction \ in /
file <- "C:\Users\YFAWC1\Documents\prenomfrance\data\Prenoms.csv"
paste(dirname(file),basename(file),sep="/")
normalizePath(file,"/",mustWork=FALSE)
gsub("\\\\", "/", file)
f= function(file){gsub("\\\\", "/", file)}

# doubler les \
# les remplacer par /
