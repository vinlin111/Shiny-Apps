
# twitter scrape by username application ----------------------------------

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


twitter_info <- function(username, number_of_tweets){
  info <- get_timeline(username, n=number_of_tweets) %>%
    as.data.frame() %>%
    select("screen_name",
           "text",
           "reply_to_screen_name",
           "is_retweet",
           "retweet_screen_name",
           "favorite_count",
           "retweet_count",
           "media_url",
           "retweet_location",
           "source")
  return(info)
}

twitter_summary <- function(username){
  user <- lookup_users(username)
  user_data <- user %>%
    select("user_id",
           "screen_name",
           "followers_count",
           "friends_count",
           "verified",
           "url",
           "source")
  return(user_data)
}

twitter_is_retweet <- function(user){
  rt <- twitter_info(user, number_of_tweets = 10000) %>%
    filter(is_retweet == TRUE)
  return(rt)
}

create_word_cloud <- function(screen_name, number_of_tweets){
  user_info <- get_timeline(user = screen_name, n = number_of_tweets)
  user_tweets <- user_info %>%
    filter(is_retweet == FALSE)
  user_tweets$text <- gsub("http.*", "", user_tweets$text)
  user_tweets$text <- gsub("https.*", "", user_tweets$text)
  user_tweets$text <- gsub("#.*", "", user_tweets$text)
  user_tweets$text <- gsub("@.*", "", user_tweets$text)
  
  emotions <- get_nrc_sentiment(user_tweets$text)
  
  tweet_wordcloud <- c(
    paste(user_tweets$text[emotions$anger > 0], collapse = " "),
    paste(user_tweets$text[emotions$anticipation > 0], collapse = " "),
    paste(user_tweets$text[emotions$disgust > 0], collapse = " "),
    paste(user_tweets$text[emotions$fear > 0], collapse = " "),
    paste(user_tweets$text[emotions$joy > 0], collapse = " "),
    paste(user_tweets$text[emotions$sadness > 0], collapse = " "),
    paste(user_tweets$text[emotions$surprise > 0], collapse = " "),
    paste(user_tweets$text[emotions$trust > 0], collapse = " ")
  )
  
  # create corpus
  corpus = Corpus(VectorSource(tweet_wordcloud))
  
  # remove punctuation, stop words, and make lower case
  corpus <- tm_map(corpus, tolower)
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeWords, c(stopwords("english")))
  corpus <- tm_map(corpus, stemDocument)
  
  # create dtm
  tdm <- TermDocumentMatrix(corpus)
  
  # convert as matrix
  tdm <- as.matrix(tdm)
  tdm_new <- tdm[nchar(rownames(tdm)) < 11,]
  
  # column name binding
  colnames(tdm) <- c("anger",
                     "anticipation",
                     "disgust",
                     "fear",
                     "joy",
                     "sadness",
                     "surprise",
                     "trust")
  colnames(tdm_new) <- colnames(tdm)
  comparison.cloud(tdm_new,
                   random.order = FALSE,
                   colors = c("#00B2FF", "red", "#FF0099", "#6600CC", "green", "orange", "blue", "brown"),
                   title.size = 1,
                   max.words = 250,
                   scale = c(2.5, 0.4),
                   rot.per = 0.4)
}

