

shinyUI(fluidPage(title="Prenoms en France",


    # div(class="outer",
    #     tags$head(
    #         # Include our custom CSS
    #         includeCSS("www/style.css")
    #     ),

    fluidRow(
    column(7, div(style = "height:650px;",
     uiOutput("ui") # affichage des MAP (selon choix du bouton radio)

   )),


        column(5, div(style = "height:650px;",

       selectInput(inputId="select_origine", label = "Origine",
          choices = levels(factor(colnames(table_dep)[c(-1,-2)])),

                           selected = 1),
       sliderInput("year", "Année", 1900, 2018, value = 2018, step=1, animate=T, sep=""),
       radioButtons("radio", label="Type de carte",
                     choices = list("Proportion par departement" = 1, "Proportion en France" = 2),
                    selected = 1),




       plotly::plotlyOutput("plot", height="70%"))

        )



)# fin fluidrow
))
#)

