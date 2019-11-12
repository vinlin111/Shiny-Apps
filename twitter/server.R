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
library(plotly)

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
  
  emotions_table <- reactive({
    info_user <- twitter_info(input$user, number_of_tweets = input$sent_n_tweets) %>%
      filter(is_retweet == FALSE) %>%
      select(text)
    info_user$text <- gsub("http.*","", info_user$text)
    info_user$text <- gsub("https.*", "", info_user$text)
    info_user$text <- gsub("#.*", "", info_user$text)
    info_user$text <- gsub("@.*", "", info_user$text)
    info_user <- info_user %>% 
      filter(nchar(text) >= 1)
    
    emotion <- get_nrc_sentiment(info_user$text)
    emotion_bars <- colSums(emotion)
    emotion_summation <- data.frame(
      count = emotion_bars,
      emotion = names(emotion_bars)
    )
    emotion_summation$emotion <- factor(emotion_summation$emotion,
                                        levels = emotion_summation$emotion[order(emotion_summation$count, decreasing = TRUE)])
    emotion_summation
  })
  
  e_plot <- reactive({
    info_user <- twitter_info(input$user, number_of_tweets = input$sent_n_tweets) %>%
      filter(is_retweet == FALSE) %>%
      select(text)
    info_user$text <- gsub("http.*","", info_user$text)
    info_user$text <- gsub("https.*", "", info_user$text)
    info_user$text <- gsub("#.*", "", info_user$text)
    info_user$text <- gsub("@.*", "", info_user$text)
    info_user <- info_user %>% 
      filter(nchar(text) >= 1)
    
    emotion <- get_nrc_sentiment(info_user$text)
    emotion_bars <- colSums(emotion)
    emotion_summation <- data.frame(
      count = emotion_bars,
      emotion = names(emotion_bars)
    )
    emotion_summation$emotion <- factor(emotion_summation$emotion,
                                        levels = emotion_summation$emotion[order(emotion_summation$count, decreasing = TRUE)])
    plot_ly(emotion_summation, x=~emotion, y=~count, type="bar", color=~emotion) %>%
      layout(xaxis=list(title=""), showlegend=FALSE,
             title="tweet emotions")
  })
  
  output$sentiment <- renderDataTable({
    emotions_table()
  })
  
  output$sentiment_plot <- renderPlotly({
    e_plot()
  })
}