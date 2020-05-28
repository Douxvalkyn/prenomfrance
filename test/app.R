library(shiny)

library(xts)
library(leaflet)
library(dplyr)

 date<-seq(as.Date("1900-01-01"), as.Date("2018-01-01"), by="year")
# a<-xts(1:10,order.by=date)
# df = data.frame(Lat = rnorm(1)+10, Long = rnorm(1),Id=a)
#
# data_a<-data.frame(a)
# data_a1<-data_a %>%
#     mutate("Lat" =as.numeric(df[1,1]),"Long"=as.numeric(df[2,1]),"Date"=rownames(data_a))
#




ui <- fluidPage(
    sliderInput("time", "date",min(date),
                max(date),
                value = max(date),
                step=1,
                animate=T),
    leafletOutput("mymap")
)

server <- function(input, output, session) {
    points <- reactive({
        data_a1 %>%
            filter(Date==input$time)
    })

    output$mymap <- renderLeaflet({
        leaflet() %>%
            addTiles(tilesURL)%>%
            addMarkers(data = points(),popup=as.character(points()$a)) %>%
            addProviderTiles("CartoDB.Positron",
                             options = providerTileOptions(maxZoom = 10, minZoom = 5))
    })
}

shinyApp(ui, server)
