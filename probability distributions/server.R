library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

server <- function(input, output){
  
  beta_dist <- reactive({
    rbeta(n = input$n_beta,
          shape1 = input$shape1,
          shape2 = input$shape2)
  })
  output$beta_dist <- renderPlot({
    beta_dist() %>% hist(breaks = 10,
                         main = "Histogram of Beta Distribution")
  })
  
  binom_dist <- reactive({
    rbinom(n = input$n_binom,
           size = input$size_binom,
           prob = input$prob_binom)
  })
  output$binom_dist <- renderPlot({
    binom_dist() %>% hist(breaks = 10,
                          main = "Histogram of Binomial Distribution")
  })
  
  norm_dist <- reactive({
    rnorm(n = input$n_norm, 
          mean = input$mu_norm,
          sd = input$sd_norm)
    })
  output$norm_dist <- renderPlot({
    norm_dist() %>% hist(breaks = 10,
                         main = "Histogram of Normal Distribution")
  })
  
  pois_dist <- reactive({
    pois_vect <- sample(seq(input$lambda_pois[1], input$lambda_pois[2], by = 0.01), size = input$samp_size_pois)
    rpois(n = input$n_pois, pois_vect)
  })
  output$pois_dist <- renderPlot({
    pois_dist() %>% hist(breaks = 10,
                         main = "Histogram of Poisson Distribution")
  })
  
  unif_dist <- reactive({
    runif(n = input$n_uniform, 
          min = 0,
          max = 1)
  })
  output$unif_dist <- renderPlot({
    unif_dist() %>% hist(breaks = 10,
                         main = "Histogram of Uniform Distribution")
  })
}