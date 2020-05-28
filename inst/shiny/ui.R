

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

fluidRow(
  column(5,     selectInput(inputId="select_origine", label = "Origine",
          choices = levels(factor(colnames(table_dep)[c(-1,-2)])),  selected = 1)),
  column(7,     sliderInput("year", "Année", 1900, 2018, value = 2018, step=1, animate=T, sep=))),

fluidRow(
       column(5, div(style = "font-size: 75%;",
               radioButtons("radio", label="Type de carte",
                     choices = list("Proportion par departement" = 1, "Proportion en France" = 2),
                    selected = 1))),
       column(7, div(style = "font-size: 75%;",
              radioButtons("radio2", label="Type de graphe",
                    choices = list("Evolution proportion enfants selon origine" = 1, "Nb prénoms représentant 90% des enfants" = 2),
                    selected = 1)))),
br(),

fluidRow( uiOutput("ui2"))# affichage des PLOT (selon choix du bouton radio2)



       )

        )



)# fin fluidrow
))
#)

