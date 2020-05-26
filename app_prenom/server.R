

library(shiny)
library(sf)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {



# PLOT evolution par origine
    output$plot <- renderPlotly({
ethnie=input$select_origine
y<-select(df_t, ethnie) %>%  unlist() %>% as.vector %>%  as.numeric %>%  round(2)

  g <-  ggplot(df_t, aes(x=annees))+
        geom_point(aes(y=y), size=1, shape=20, color="blue") +
        ggtitle("Evolution de la proportion des enfants selon l'origine du prénom") +
        xlab("Années") + ylab("% de bébés")+
      theme(plot.title = element_text(size=10))

  h<- ggplotly(g) %>% config(displayModeBar = F)

  return(h)

    })




 # LEAFLET  carte departementale
    output$mymap <- leaflet::renderLeaflet({
      map_dep <- st_read(dsn="Z:/prenoms/a_dep.shp")

      # gestion corse unifiée
      corse=st_union(map_dep %>%  filter(codgeo %in% c("2A", "2B")), by_feature = FALSE) #selection des deux dep corses
      class(corse) # Cette opération créé un objet sfc
      corse_ <- st_sf(codgeo ="20", libgeo="Corse", geometry=corse) # Que l'on retransforme en objet sf
      # on supprime les 2 dep corses et on remet la corse unifiée
      map_dep_ <- map_dep %>%  filter (!(codgeo %in% c("2A", "2B"))) %>%  rbind(corse_)
      map_dep_4326 <-st_transform(map_dep_, 4326) %>%  rename(CODGEO=codgeo)

      ethnie=input$select_origine
      df_t_filtre <- filter(df_t_dep, annee=="2018") %>%  select (dep,ethnie) %>%
        rename(CODGEO=dep, ethnie= ethnie)
      map <- left_join(map_dep_4326, df_t_filtre, by="CODGEO")
      map$ethnie <- as.numeric(as.vector(map$ethnie))

     #gestion de la discretisation des classes et de la palette
      library(classInt)
      classes<-classInt::classIntervals(map$ethnie, 5, style="jenks")
      pal <- colorBin("YlOrRd", domain =  map$ethnie, bins = classes$brks)

      #label au survol
      labels <- sprintf(
        "<strong>Dep: %s</strong> <br/> %g &#37; ",
        map$CODGEO, round(map$ethnie ,2)
      ) %>% lapply(htmltools::HTML)

      #leaflet
      leaflet::leaflet(map) %>%
        addProviderTiles("CartoDB.Positron",
                         options = providerTileOptions(maxZoom = 10, minZoom = 5)) %>%
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
            bringToFront = TRUE))  %>%
        addLegend(pal = pal, values = ~density, opacity = 0.7, title = NULL,
                  position = "topright") %>%
        setView( 2, 46.6,6)



    })

    output$mymap2 <- leaflet::renderLeaflet({
      map_dep <- st_read(dsn="Z:/prenoms/a_dep.shp")

      # gestion corse unifiée
      corse=st_union(map_dep %>%  filter(codgeo %in% c("2A", "2B")), by_feature = FALSE) #selection des deux dep corses
      class(corse) # Cette opération créé un objet sfc
      corse_ <- st_sf(codgeo ="20", libgeo="Corse", geometry=corse) # Que l'on retransforme en objet sf
      # on supprime les 2 dep corses et on remet la corse unifiée
      map_dep_ <- map_dep %>%  filter (!(codgeo %in% c("2A", "2B"))) %>%  rbind(corse_)
      map_dep_4326 <-st_transform(map_dep_, 4326) %>%  rename(CODGEO=codgeo)



    # calcul de la repartition par origine et par departement
    ethnie=input$select_origine
    annee="2018"
    base_an <- dplyr::filter(base, annais==annee)
    base_an_ethnie <- base_an %>% dplyr::filter(stringr::str_detect(origine,ethnie))
    total_france = base_an_ethnie  %>% summarise(sum(nombre)) %>% unlist() %>%  as.numeric()
    tab=base_an_ethnie %>%  group_by(dpt) %>% summarise(s=sum(nombre)) %>%  mutate(pct= 100*s/total_france) %>% rename (CODGEO=dpt)


    map2 <- left_join(map_dep_4326, tab, by="CODGEO")

    classes<-classInt::classIntervals(map2$pct, 5, style="jenks")
    pal <- colorBin("YlOrRd", domain = map2$pct, bins = classes$brks)

    #label au survol
    labels <- sprintf(
      "<strong>Dep: %s</strong> <br/> %g &#37; ",
      map$CODGEO, round(map2$pct ,2)
    ) %>% lapply(htmltools::HTML)




    #leaflet
    leaflet::leaflet(map2) %>%
      addProviderTiles("CartoDB.Positron",
                       options = providerTileOptions(maxZoom = 10, minZoom = 5)) %>%
      addPolygons(
        fillColor = ~pal(pct),
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
               position = "topright") %>%
      setView( 2, 46.6,6)

})




# gestion ui dynamique (radio bouton)
    output$ui <- renderUI({
      switch(
        input$radio,
        "1" = leaflet::leafletOutput(outputId = "mymap", height="700px"),
        "2" = leaflet::leafletOutput(outputId = "mymap2", height="700px")
      )

    })

})
