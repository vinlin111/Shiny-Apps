library(shiny)
library(tidyverse)
library(kableExtra)
library(ggplot2)
library(stringr)
library(rtweet)
library(RCurl)
library(httr)
library(wordcloud)
library(tm)
library(syuzhet)

server <- function(input, output){
  
  artist_info <- reactive({
    twitter_summary(input$user)
  })
  
  artist_info_activity <- reactive({
    twitter_info(input$user, number_of_tweets = input$num_tweets)
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