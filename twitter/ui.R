library(shiny)
library(tidyverse)
library(kableExtra)
library(ggplot2)
library(stringr)
library(RCurl)
library(httr)
library(wordcloud)
library(tm)
library(syuzhet)
library(rtweet)

ui <- fluidPage(
  titlePanel("Twitter Username Stories"),
  tabsetPanel(
    tabPanel("Username Summary",
             sidebarLayout(
               sidebarPanel(
                 textInput(inputId = "user",
                           label = "username/screen name",
                           value = "brysontiller"),
                 numericInput(inputId = "num_tweets",
                              label = "max number of tweets scraped",
                              value = "100")
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
    
    tabPanel("Retweet Activity",
             mainPanel(
               dataTableOutput(
                 outputId = "retweets"
               )
             )
             ),
    
    tabPanel("Popular Advertisements & Topics"),
    
    tabPanel("Sentiment Analysis")
  )
)