server <- function(input, output){
  
  artist_info <- reactive({
    twitter_summary(input$user)
  })
  
  artist_info_activity <- reactive({
    twitter_info(input$user, 10)
  })
  
  output$summaryTable <- renderTable({
    artist_info()
  })
  
  output$sumTab <- renderTable({
    artist_info_activity()
  })
  
}