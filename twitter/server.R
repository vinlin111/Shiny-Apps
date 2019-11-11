server <- function(input, output){
  
  artist_info <- reactive({
    twitter_summary(input$user)
  })
  
  artist_info_activity <- reactive({
    twitter_info(input$user, 10)
  })
  
  artist_retweet <- reactive({
    twitter_is_retweet(input$user)
  })
  
  output$summaryTable <- renderTable({
    artist_info()
  })
  
  output$sumTab <- renderTable({
    artist_info_activity() 
  })
  
  output$retweets <- renderDataTable({ 
    artist_retweet()
  }, options = list(pageLength = 10))
  
}