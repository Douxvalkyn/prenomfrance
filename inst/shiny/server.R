

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

})
