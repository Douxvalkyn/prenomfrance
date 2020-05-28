#
# library(dplyr)
# ####-------------- SAVE -----------------------------------------------------------
# save(base_nat,file= "data/base_nat.rda") #base nationale
# save(base_dep,file= "data/base_dep.rda") #base dep
# save(table_nat,file= "data/table_nat.rda") #taux nationaux
# save(table_dep,file= "data/table_dep.rda") #taux dep



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


# # faire une liste des prenoms par origine et par annee et par sexe
# top <- base %>%  filter(str_detect(origine,"arabic")) %>%
#   filter(str_detect(annais, "2018")) %>%
#   filter(str_detect(sexe, paste(c(1,2), collapse="|"))) %>%
#   arrange(desc(nombre))
#
#
#
# # recherche de prenom dans base
# test=filter(test, prenom=="DAVID") %>%
#   filter(str_detect(annais, "2018"))
#
#

#
# ##### Indice de concentration des prenoms ------------------------------------------
#
#
# annees= unique(nat2018$annais) %>%  as.vector %>% unlist() %>%  sort()
# annees <- annees[annees != "XXXX"]
#
# result=NULL
# i=1
# for (an in annees){
# base_an<- nat2018 %>%  filter(annais==an) %>%  filter(prenom != "_PRENOMS_RARES")
# x<-sort(base_an$nombre, decreasing = T)
# h2 <- cumsum(x*100/sum(x))
#
# result[i]<- length(h2[h2<90])
# i=i+1
# }
#
# plot(annees, result)
# concentration<-cbind(annees, result) %>%  as.data.frame()
# concentration$result=as.numeric(as.vector(concentration$result))
#
# # graphique ggplot
# library(ggplot2)
# ggplot(concentration, aes(x=annees))+
#   geom_point(aes(y=result), size=2, shape=16, color="blue") +
#   ggtitle("Nombre de prénoms pour représenter 90% des enfants") +
#   xlab("Années") + ylab("nb prenoms") + ylim(0, 3500) +
#   scale_x_discrete(breaks=c("1900", "1920", "1940", "1960", "1980", "2000", "2020"))
#
# origines= colnames(base)
# origines=origines[-1]
