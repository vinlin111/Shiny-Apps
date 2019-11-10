library(shiny)
library(tidyverse)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  titlePanel("probability distributions"),
  
  tabsetPanel(
    
    tabPanel("Beta",
             sidebarLayout(
               sidebarPanel(
                 numericInput(inputId = "n_beta",
                              label = "n",
                              value = 100),
                 numericInput(inputId = "shape1",
                              label = "shape1",
                              value = 0.5,
                              step = 0.01),
                 numericInput(inputId = "shape2",
                              label = "shape2",
                              value = 1.5,
                              step = 0.01)),
               mainPanel(
                         plotOutput("beta_dist")
                         )
               )
             ),
    
    tabPanel("Binomial",
             sidebarLayout(
               sidebarPanel(
                 numericInput(inputId = "n_binom",
                              label = "n",
                              value = 100),
                 numericInput(inputId = "size_binom",
                              label = "number of trials",
                              value = 100),
                 numericInput(inputId = "prob_binom",
                              label = "probability",
                              value = 0.5,
                              step = 0.01)
               ),
               mainPanel(
                 plotOutput("binom_dist")
               )
             )),
    
    tabPanel("Normal",
             sidebarLayout(
               sidebarPanel(
                 numericInput(inputId = "n_norm",
                              label = "n",
                              value = 100),
                 numericInput(inputId = "mu_norm",
                              label = "mean",
                              value = 1.001,
                              step = 0.001),
                 numericInput(inputId = "sd_norm",
                              label = "standard deviation",
                              value = 0.995,
                              step = 0.001)
               ),
               mainPanel(
                 plotOutput("norm_dist")
               )
             )),
    
    tabPanel("Poisson",
             sidebarLayout(
               sidebarPanel(
                 numericInput(inputId = "n_pois",
                              label = "n",
                              value = 100),
                 sliderInput(inputId = "lambda_pois",
                             label = "lambda vector range",
                             min = 0,
                             max = 10000,
                             value = c(50, 75),
                             step = 5),
                 numericInput(inputId = "samp_size_pois",
                              label = "sample size of lambda vector",
                              value = 100)
               ),
               mainPanel(
                 plotOutput("pois_dist")
               )
             )),
    
    tabPanel("Uniform",
             sidebarLayout(
               sidebarPanel(
                 numericInput(inputId = "n_uniform",
                              label = "n",
                              value = 100)
               ),
               mainPanel(
                 plotOutput("unif_dist")
               )
             ))
    
    
    
  )
)