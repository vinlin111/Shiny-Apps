server <- function(input, output){
  dataInput <- reactive({
    getSymbols(input$symb, 
               src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  output$plot <- renderPlot({
    chartSeries(dataInput(),
                theme = chartTheme("black",),
                type = "line",
                log.scale = TRUE,
                TA = NULL)
  })
}