

shinyUI(fluidPage(title="Prenoms en France",



navbarPage("",
    tabPanel("Main",



    fluidRow(
    column(7, div(style = "height:650px;",
     uiOutput("ui") # affichage des MAP (selon choix du bouton radio)

   )),


    column(5, div(style = "height:650px;",

fluidRow(
  column(5,     selectInput(inputId="select_origine", label = "Origine",
          choices = levels(factor(colnames(table_dep)[c(-1,-2)])),  selected = 1)),
  column(7,     sliderInput("year", "Année", 1900, 2018, value = 2018, step=1, animate=T, sep=""))),

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

))
) #fin fluidrow tabpanel1
) # fin tabpanel1"
,


tabPanel("Popularité",
fluidRow(
    column(4,
         selectInput("wordcloud_origine",label="Origine",
                     choices=c(Choix='', levels(factor(colnames(table_dep)[c(-1,-2)]))), selectize=FALSE),
         sliderInput("wordcloud_annees", label="Annees", min = 1900, max = 2018, value=c(1900,2018), sep=""),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
         textInput("prenom_popularite", label = "Choix prénom", value="Marc"),
         plotly::plotlyOutput("plot_popularite", width="80%")
         ),
   column(8,
         wordcloud2Output("wordcloud", width = "85%"),
         br(),
         fluidRow( column(1,),column(4,tableOutput("top_h")),column(4,tableOutput("top_f")))
   )


) # fin fluid row du tabpanel2
)# fin tabpanel 2
,

tabPanel("Réseau",
         column(3,
                textInput("prenom_graphe", label = "Choix prénom", value="Joseph"),
                sliderInput("seuil_graphe", label="Seuil de proximité", min=0, max=0.25,value=0.15, step=0.05),
                sliderInput("annees_graphe", label="Années", min=1900, max=2018,value=c(1980,2018), sep="")
                ),
         column(9,  visNetworkOutput("network", height = "750px",width="100%" ))
)# fin tabpanel3




) # fin navBar
) # fin fluidPage
) # fin shinyUI




