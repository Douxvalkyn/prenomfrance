library(ggplot2)
library(plotly)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(title="Prenoms en France",


    # div(class="outer",
    #     tags$head(
    #         # Include our custom CSS
    #         includeCSS("www/style.css")
    #     ),

    fluidRow(
    column(7, div(style = "height:650px;",
     uiOutput("ui")

   )),


        column(5, div(style = "height:650px;",

       selectInput(inputId="select_origine", label = "Origine",
          choices = list("spanish"="spanish", "english"="english", "arabic"="arabic",
                                     "african"="african", "hungarian"="hungarian", "french"="french",
                                     "jewish"="jewish", "italian"="italian", "greek"="greek",
                                     "german"="german", "polish"="polish", "russian"="russian",
                                     "romanian"="romanian", "portuguese"="portuguese", "turkish"="turkish",
                                     "indian"="indian", "dutch"="dutch", "welsh"="welsh",
                                     "scandinavian"="scandinavian", "irish"="irish", "scottish"="scottish",
                                     "basque"="basque", "japanese"="japanese", "danish"="danish",
                                     "slovene"="slovene", "bulgarian"="bulgarian", "macedonian"="macedonian",
                                     "croatian"="croatian", "serbian"="serbian", "finnish"="finnish",
                                     "czech"="czech", "slovak"="slovak", "breton"="breton",
                                      "catalan"="catalan", "provençal"="provençal", "ukrainian"="ukrainian",
                                     "celtic"="celtic", "icelandic"= "icelandic"),

                           selected = 1),

        radioButtons("radio", label="Type de carte",
                     choices = list("Proportion par departement" = 1, "proportion en France" = 2),
                    selected = 1),


       plotlyOutput("plot", height="70%"))

        )



)# fin fluidrow
))
#)

