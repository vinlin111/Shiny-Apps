library(shiny)
library(tidyverse)
library(ggplot2)
library(rvest)
library(quantmod)

ui <- fluidPage(
  titlePanel("Stock Visualization"),
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "symb",
                label = "Symbol",
                value = "MSFT"),
      dateRangeInput(inputId = "dates",
                     label = "Date Range",
                     start = "2019-01-01",
                     end = Sys.Date())
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)