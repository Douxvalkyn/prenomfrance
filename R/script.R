


####-------------- Import données -----------------------------------------------------------
load("data/dpt2018_fichier_initial.rda")
load("data/nat2018_fichier_initial.rda")
load("data/prenoms_fichier_initial.rda")
fichier_insee <- mise_forme_fichier_insee(dpt2018_fichier_initial)
fichier_prenoms <-mise_forme_fichier_prenoms(prenoms_fichier_initial)
df_t_dep<-creation_base_dep(fichier_insee,fichier_prenoms)

save(base, "data/base.rda")
save(df_t,file= "data/df_t.rda") #taux nationaux
save(df_t_dep,file= "data/df_t_dep.rda") #taux dep


# faire une liste des prenoms par origine et par annee et par sexe
top <- base %>%  filter(str_detect(origine,"arabic")) %>%
  filter(str_detect(annais, "2018")) %>%
  filter(str_detect(sexe, paste(c(1,2), collapse="|"))) %>%
  arrange(desc(nombre))



# graphique ggplot
library(ggplot2)
ggplot(df_t, aes(x=annee))+
  geom_point(aes(y=as.numeric(as.vector(df_t$arabic))), size=2, shape=16, color="blue") +
  ggtitle("Evolution de la part des prénoms selon l'origine") +
  xlab("Années") + ylab("% de bébés")

# recherche de prenom dans base
test=filter(test, prenom=="DAVID") %>%
  filter(str_detect(annais, "2018"))



#### ------- Carte de France par département des prénoms par origine ------------------
# avec la base par départements
# map du dep (pour changer des carreaux)

library(leaflet)
library(outils)
library(sf)

#map<- st_read(dsn="C:/Users/YFAWC1/Documents/prenomfrance/data-raw/dep.shp")



#### Fusion des deux départements corses
map_dep <- st_read(dsn="Z:/prenoms/a_dep.shp")
plot(map_dep$geometry)


corse=st_union(map_dep %>%  filter(codgeo %in% c("2A", "2B")), by_feature = FALSE) #selection des deux dep corses
class(corse) # Cette opération créé un objet sfc
corse_ <- st_sf(codgeo ="20", libgeo="Corse", geometry=corse) # Que l'on retransforme en objet sf

# on supprime les 2 dep corses et on remet la corse unifiée
map_dep_ <- map_dep %>%  filter (!(codgeo %in% c("2A", "2B"))) %>%  rbind(corse_)

plot(map_dep_$geometry)

map_dep_4326 <-st_transform(map_dep_, 4326) %>%  rename(CODGEO=codgeo)



df_t_filtre <- filter(df_t, annee=="2018") %>%  select (dep,"arabic") %>%
  rename(CODGEO=dep, ethnie= arabic)

map <- left_join(map_dep_4326, df_t_filtre, by="CODGEO")

map$ethnie <- as.numeric(as.vector(map$ethnie))






library(classInt)
classes<-classInt::classIntervals(map$ethnie, 5, style="jenks")
pal <- colorBin("YlOrRd", domain =  map$ethnie, bins = classes$brks)

#label au survol
labels <- sprintf(
  "<strong>Dep: %s</strong> <br/> %g &#37; ",
  map$CODGEO, round(map$ethnie ,2)
) %>% lapply(htmltools::HTML)


 leaflet::leaflet(map) %>%
  leaflet::addTiles(urlTemplate = "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png") %>%
  addPolygons(
  fillColor = ~pal(ethnie),
  weight = 2,
  opacity = 1,
  color = "white",
  #popup = paste(map_test$CODGEO,round(map_test$ethnie,3), sep = "<br/>") ,
  label=labels,
  dashArray = "3",
  fillOpacity = 0.7,
  highlight = highlightOptions(
    weight = 3,
    color = "#666",
    dashArray = "",
    fillOpacity = 0.7,
    bringToFront = TRUE)) %>%
  addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
              position = "bottomright")


##### Indice de concentration des prenoms ------------------------------------------


annees= unique(nat2018$annais) %>%  as.vector %>% unlist() %>%  sort()
annees <- annees[annees != "XXXX"]

result=NULL
i=1
for (an in annees){
base_an<- nat2018 %>%  filter(annais==an) %>%  filter(prenom != "_PRENOMS_RARES")
x<-sort(base_an$nombre, decreasing = T)
h2 <- cumsum(x*100/sum(x))

result[i]<- length(h2[h2<90])
i=i+1
}

plot(annees, result)
concentration<-cbind(annees, result) %>%  as.data.frame()
concentration$result=as.numeric(as.vector(concentration$result))

# graphique ggplot
library(ggplot2)
ggplot(concentration, aes(x=annees))+
  geom_point(aes(y=result), size=2, shape=16, color="blue") +
  ggtitle("Nombre de prénoms pour représenter 90% des enfants") +
  xlab("Années") + ylab("nb prenoms") + ylim(0, 3500) +
  scale_x_discrete(breaks=c("1900", "1920", "1940", "1960", "1980", "2000", "2020"))

origines= colnames(base)
origines=origines[-1]
