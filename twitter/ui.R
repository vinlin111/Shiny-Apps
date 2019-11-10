ui <- fluidPage(
  titlePanel("Twitter Username Stories"),
  tabsetPanel(
    tabPanel("Username Summary",
             sidebarLayout(
               sidebarPanel(
                 textInput(inputId = "user",
                           label = "username/screen name",
                           value = "brysontiller")
               ),
               mainPanel(
                 tableOutput(
                   outputId = "summaryTable"
                 ), br(), br(),
                 tableOutput(
                   outputId = "sumTab"
                 )
               )
              )
             ),
    
    tabPanel("Retweet Activity"),
    
    tabPanel("Popular Advertisements & Topics"),
    
    tabPanel("Sentiment Analysis")
  )
)