library(shiny)
library(tidyverse)
library(stringr)



ui <- fluidPage(
  titlePanel("Stock Analytics"),
  tabsetPanel(
    tabPanel("Stock Trends",
      sidebarLayout(
        sidebarPanel(
          sliderInput("priceInput", "Current Stock Price: ", 0 , 2500, c(100,250)),
          radioButtons("typeInput", "Stock Industry",
                       choices = c("Technology", "Pharmaceuticals", "Social Media"),
                       selected = "Technology"),
          numericInput("nTimes", "n = ", value = 100, min = 50, max = 100000)
        ),
        mainPanel("Trend and Pattern Plots will go here",
                  plotOutput("stockPlot"),
                  tableOutput("stockTable")
                  )
      )
    ),
    tabPanel("Prediction with Monte Carlo Simulation",
             mainPanel(
               plotOutput("mcPlot")
             )
    )
  )
)
