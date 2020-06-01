

shinyServer(function(input, output) {



#---------- PLOT evolution par origine ----------------------------------------------------------------
output$plot <- plotly::renderPlotly({
    ethnie=input$select_origine
    y<-dplyr::select(table_nat, ethnie) %>%  unlist() %>% as.vector %>%  as.numeric %>%  round(2)

    g <-  ggplot2::ggplot(table_nat, ggplot2::aes(x=annee))+
            ggplot2::geom_point(ggplot2::aes(y=y), size=1, shape=20, color="cornflowerblue") +
            ggplot2::ggtitle("Evolution de la proportion d'enfants selon l'origine du prénom") +
            ggplot2::xlab("Années") +
            ggplot2::ylab("Proportion de bébés")+
            ggplot2::theme(plot.title = ggplot2::element_text(size=10))

    h<- plotly::ggplotly(g) %>% plotly::config(displayModeBar = F) # pour cacher la barre de menu plotly

    return(h)

  })



##### creation base de la MAP pour les deux map leaflet -------------------------------------------
map <- reactive({

  # gestion corse unifiée
  # map_dep est sauvegardé dans le dossier data
  corse <- sf::st_union(map_dep %>%  dplyr::filter(codgeo %in% c("2A", "2B")), by_feature = FALSE) #selection des deux dep corses
  class(corse) # Cette opération créé un objet sfc
  corse_ <- sf::st_sf(codgeo ="20", libgeo="Corse", geometry=corse) # Que l'on retransforme en objet sf
  # on supprime les 2 dep corses et on remet la corse unifiée
  map_dep_ <- map_dep %>%  dplyr::filter (!(codgeo %in% c("2A", "2B"))) %>%  rbind(corse_)
  map_dep_4326 <-sf::st_transform(map_dep_, 4326) %>% dplyr:: rename(CODGEO=codgeo)

})


####----- LEAFLET  carte departementale-----------------------------------------------------------------

output$mymap <- leaflet::renderLeaflet({


      ethnie=input$select_origine
      annee=input$year
      map_dep_4326 <-map()
      # ethnie="african"
      # annee="1940"

      # table_dep est sauvegarde dans data
      table_dep_filtre <- table_dep %>% dplyr::filter( annee==!!annee) %>%  dplyr::select (dep,ethnie) %>%
        dplyr::rename(CODGEO=dep, ethnie= ethnie)

      map <- dplyr::left_join(map_dep_4326, table_dep_filtre, by="CODGEO")

      map$ethnie <- as.numeric(as.vector(map$ethnie))




     #gestion de la discretisation des classes et de la palette

      if ( length(na.omit(map$ethnie[map$ethnie!=0])) == 0) {
        pal <- leaflet::colorBin("YlOrRd", domain =  map$ethnie, bins = c(0,1))  }
      if ( length(na.omit(map$ethnie[map$ethnie!=0])) != 0) {

      classes<-classInt::classIntervals(na.omit(map$ethnie), 5, style="jenks")
      pal <- leaflet::colorBin("YlOrRd", domain =  map$ethnie, bins = unique(classes$brks))
      }




      #label au survol
      labels <- sprintf(
        "<strong>Dep: %s</strong> <br/> %g &#37; ",
        map$CODGEO, round(map$ethnie ,2)
      ) %>% lapply(htmltools::HTML)

      #leaflet
      leaflet::leaflet(map) %>%
        leaflet::addProviderTiles("CartoDB.Positron",
                         options = leaflet::providerTileOptions(maxZoom = 10, minZoom = 5)) %>%
        leaflet::addPolygons(
          fillColor = ~pal(ethnie),
          weight = 2,
          opacity = 1,
          color = "white",
          label=labels,
          dashArray = "3",
          fillOpacity = 0.7,
          highlight = leaflet::highlightOptions(
            weight = 3,
            color = "#666",
            dashArray = "",
            fillOpacity = 0.7,
            bringToFront = TRUE))  %>%
     leaflet::addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
                  position = "topright") %>%
        leaflet::setView( 2, 46.6,6)



    })



####--------------------LEAFLET map2-------------------------------------------------------------------
output$mymap2 <- leaflet::renderLeaflet({
      map_dep_4326<- map()

    # calcul de la repartition par origine et par departement
    ethnie=input$select_origine
    annee=input$year
    #   ethnie="serbian"
    #   annee="1900"

    # base_dep est sauvegardé dans data
    base_an <- dplyr::filter(base_dep, annais==!!annee)
    base_an_ethnie <- base_an %>% dplyr::filter(stringr::str_detect(origine,ethnie))
    total_france <- base_an_ethnie  %>% dplyr::summarise(sum(nombre)) %>% unlist() %>%  as.numeric()
    tab=base_an_ethnie %>%  dplyr::group_by(dpt) %>% dplyr::summarise(s=sum(nombre)) %>%
      dplyr::mutate(pct= 100*s/total_france) %>% dplyr::rename (CODGEO=dpt)


    map2 <- dplyr::left_join(map_dep_4326, tab, by="CODGEO")



    # attention si aucune valeur ou (une seule valeur et toutes les autres NA) : palette spéciale
    # sinon, discretisation JENKS
    if (length(na.omit(map2$pct)) <= 1) {
      pal <- leaflet::colorBin("YlOrRd", domain =  map2$pct, bins = c(0,1))   }
    if (length(na.omit(map2$pct)) > 1) {
      classes<-classInt::classIntervals(map2$pct, 5, style="jenks")
      pal <-leaflet:: colorBin("YlOrRd", domain = map2$pct, bins =  unique(classes$brks))
    }



    #label au survol
    labels <- sprintf(
      "<strong>Dep: %s</strong> <br/> %g &#37; ",
      map2$CODGEO, round(map2$pct ,2)
    ) %>% lapply(htmltools::HTML)




    #leaflet
    leaflet::leaflet(map2) %>%
      leaflet::addProviderTiles("CartoDB.Positron",
                       options = leaflet::providerTileOptions(maxZoom = 10, minZoom = 5)) %>%
      leaflet::addPolygons(
        fillColor = ~pal(pct),
        weight = 2,
        opacity = 1,
        color = "white",
        #popup = paste(map_test$CODGEO,round(map_test$ethnie,3), sep = "<br/>") ,
        label=labels,
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = leaflet::highlightOptions(
          weight = 3,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE)) %>%
      leaflet::addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
               position = "topright") %>%
      leaflet::setView( 2, 46.6,6)

})
####------------------- PLOT concentration des prénoms---------------------------------------------------

output$plot2 <- plotly::renderPlotly({


annees <- unique(base_nat$annais) %>%  as.vector %>% unlist() %>%  sort()
annees <- annees[annees != "XXXX"]

result=NULL
i=1
for (an in annees){
  base_an <- base_nat %>% dplyr::filter( annais==!!an) %>%  dplyr::filter(prenom != "_PRENOMS_RARES")
  x <-sort(base_an$nombre, decreasing = T)
  h2 <- cumsum(x*100/sum(x))

result[i] <- length(h2[h2<90])
i=i+1
}


concentration <- cbind(annees, result) %>%  as.data.frame()
concentration$result <-as.numeric(as.vector(concentration$result))

# graphique ggplot
g <- ggplot2::ggplot(concentration, ggplot2::aes(x=annees))+
  ggplot2::geom_point(ggplot2::aes(y=result),size=1, shape=20, color="darkolivegreen3") +
  ggplot2::ggtitle("Nombre de prénoms pour représenter 90% des enfants") +
  ggplot2::xlab("Années") +
  ggplot2::ylab("nb prenoms") + ggplot2::ylim(0, 3500) +
  ggplot2::scale_x_discrete(breaks=c("1900", "1925", "1950", "1975",  "2000")) +
  ggplot2::theme(plot.title = ggplot2::element_text(size=10))


h <- plotly::ggplotly(g) %>% plotly::config(displayModeBar = F) # pour cacher la barre de menu plotly

return (h)
})


####-------------------- Top prenoms ---------------------------------------------------------

library(wordcloud2)

# base qui sert au wordcloud et aux top prenoms
b <- reactive({

  origine <-input$wordcloud_origine
  annee <-input$wordcloud_annees

  b<-base_nat %>%
    dplyr::filter( as.vector(annais)>=!!annee[1]) %>%
    dplyr::filter( as.vector(annais)<=!!annee[2])

  # trier selon l'origine si une origine est sélectionnée
  if (origine !=""){
    b<- b %>%   dplyr::filter(stringr::str_detect(origine, !!origine))
  }


  b <- b %>% dplyr::group_by(sexe,prenom) %>%
    dplyr::summarise(nb=sum(nombre)) %>%
    dplyr::filter(prenom != "_PRENOMS_RARES") %>% dplyr::arrange(desc(nb))

  # enlever les prenoms trop rares
  b <- b %>% dplyr::filter(nb>10)
})





# afficher top hommes
output$top_h <- renderTable({
 b<- b()
b <- b %>%  dplyr::filter(sexe=="1") %>%  dplyr::ungroup() %>% dplyr::select(prenom, nb)
  head(b, n=10)
})


# afficher top femmes
output$top_f <- renderTable({
  b<- b()
b <- b %>%  dplyr::filter(sexe=="2") %>%  dplyr::ungroup() %>% dplyr::select(prenom, nb)
  head(b, n=10)
})



output$wordcloud <-renderWordcloud2({
b<- b()
b <- b %>%  dplyr::ungroup() %>% dplyr::select(prenom, nb)

 wordcloud2a(b, size=0.5, shape = "circle")

})


####----------------------Gestion UI dynamiques--------------------------------------------------------

# gestion ui dynamique (radio bouton 1)
    output$ui <- renderUI({
      switch(
        input$radio,
        "1" = leaflet::leafletOutput(outputId = "mymap", height="700px"),
        "2" = leaflet::leafletOutput(outputId = "mymap2", height="700px")
      )

    })

 # gestion ui dynamique (radio bouton 2)
    output$ui2 <- renderUI({
      switch(
        input$radio2,
        "1" = plotly::plotlyOutput("plot", height="80%"),
        "2" = plotly::plotlyOutput("plot2", height="80%")
      )

    })

####---------------------- Graphe relationnel -------------------------------------------

   output$network <- renderVisNetwork({

     req(input$prenom_graphe)

     ### Variables en entrée et base de recherche
     annee=input$annees_graphe
     seuil_graphe <- input$seuil_graphe

     base_an <- base_nat %>%
        dplyr::filter(nombre > 9) %>% # minimum 10 occurences par an
        dplyr::filter( as.vector(annais)>=!!annee[1]) %>%    # filtre sur les années
        dplyr::filter( as.vector(annais)<=!!annee[2])        # filtre sur les années

     base <- base_an  %>%
        dplyr::group_by (prenom,origine) %>%
        dplyr::summarise(nb=sum(nombre)) %>%
        dplyr::ungroup() %>%
        dplyr::filter(nb>49) #minimum 50 occurences sur la période

      prenoms_all <- na.omit(base$prenom) %>% as.vector() # tous les prenoms pour faire la recherche
      prenom <- stringr::str_to_upper(input$prenom_graphe)


     ### Detection des prenoms proches avec la distance de Jaro Winkler

      # NIV 1: on ne fait la recherche que si le prenom cherché est dans la base
      if (length(base$prenom[base$prenom == prenom])>0){
        liste <- recherche_prenoms_proches(prenom, seuil_graphe, prenoms_all)
        a=unlist(liste[1])
        b=unlist(liste[2])
        c=unlist(liste[3])


      # NIV 2: on recherche les prenoms proches de tous les prenoms proches du prenom d'interet
       for (name in unlist(liste[1])){
         liste2 <- recherche_prenoms_proches(name, seuil_graphe, prenoms_all)
         a=append (a, unlist(liste2[1]))
         b=append (b, unlist(liste2[2]))
         c=append (c, unlist(liste2[3]))
        }


      ### Creation du reseau relationnel uniquement si des prenoms proches ont été trouvées
      if (length(liste[1])>0 & !(is.null(unlist(liste[1])))){


      # necessite nodes (liste des noeuds) et links (liste des liens)
      source=rep(prenom, length(unlist(liste[1])))
      for (i in 1:length(c)-1){
        source=append(source, rep( unlist( liste[1])[i], c[i+1]))
      }
      target=a
      links=cbind(source, target, b) %>%  as.data.frame() %>%  dplyr::rename(weight=b)
      links$weight= as.numeric(as.vector(links$weight))
      id =unique(c(prenom,a))
      nodes = id %>%  as.data.frame()


      # construction du reseau avec igraph
      reseau <- igraph::graph_from_data_frame(d=links, vertices=nodes, directed=F)
      reseau <- igraph::simplify(reseau) # suppression des liens multiples
      # plot(reseau)


      # utilisation de VisNetwork pour afficher un graphe dynamique interactif
      data <- toVisNetworkData(reseau)

      # recherche des valeurs (nb d'occurences des prenoms) des noeuds
      values=NULL
       for (name in data$nodes$id){
        values= append(values,base$nb[base$prenom==name])
       }

      # recherche des origines  des noeuds
      origines=NULL
      for (name in data$nodes$id){
        origines= append(origines,base$origine[base$prenom==name])
      }

      # recherche du sexe  des noeuds (on choisit le sexe le plius représenté si prenom multi-sexe)
    sexes=NULL
    for (name in data$nodes$id){
        b <- base_an %>%  dplyr::group_by(sexe, prenom) %>% dplyr::summarise(nb=sum(nombre)) %>%
        dplyr::arrange(desc(nb), prenom, sexe)
        sexes= append(sexes,first(b$sexe[b$prenom==name]))
     }
      sexes[sexes==1] <-"H"
      sexes[sexes==2] <-"F"

      # on renseigne les valeurs, origines, titres des noeuds et longueur des liens
      data$nodes$value= values
      data$nodes$group= sexes
      #data$nodes$title=values
      data$nodes$title=paste0("Effectif: ", values, "<br>", "Origine: ", origines )
      data$edges$length=data$edges$weight
      data$nodes$origine= origines


      #affichage dynamique
      visNetwork(nodes = data$nodes, edges = data$edges, height = "750px", width="100%") %>%
         visLegend(width=0.2, position = "right")   %>%
        visGroups(groupname="H", color="dodgerblue") %>%
        visGroups(groupname="F", color="pink")

      }
}# If PRENOM EXISTE
    })


})
