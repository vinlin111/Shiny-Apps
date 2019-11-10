server <- function(input, output){
  normal_distribution <- reactive({
    rnorm(input$nTimes, 
          mean = 1.001,
          sd = 0.005)
  })

  output$stockPlot <- renderPlot({
    normal_distribution() %>% hist(breaks = 10, 
                                   main = "Histogram of Distribution")
  })
  
  output$stockTable <- renderTable({
    n <- paste("n =", seq(1, length(normal_distribution())))
    data.frame(n = n,
               value = normal_distribution()) 
  })
  
  output$mcPlot <- renderPlot({
    plot(cumprod(c(25, normal_distribution())), 
         type = "l", 
         xlab = "Day",
         ylab = "Stock Price",
         main = "Monte Carlo Stock Prediction")
  })
}