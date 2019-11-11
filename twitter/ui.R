library(shiny)
library(tidyverse)
library(kableExtra)
library(ggplot2)
library(stringr)
library(twitteR)
library(RCurl)
library(httr)
library(wordcloud)
library(tm)
library(syuzhet)

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