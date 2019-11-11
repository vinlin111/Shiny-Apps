
# twitter scrape by username application ----------------------------------

library(tidyverse)
library(ggplot2)
library(twitteR)
library(rtweet)
library(ggpubr)
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

clean_twitter <- function(user){
  t <- twitter_info(user, number_of_tweets = 10000) %>%
    filter(is_retweet == FALSE) %>%
    select("text")
  # cleaning the data
  t$text <- gsub("http.*","", t$text)
  t$text <- gsub("https.*", "", t$text)
  t$text <- gsub("#.*", "", t$text)
  t$text <- gsub("@.*", "", t$text)
  t %>% 
    filter(nchar(text) >= 1)
  return(t)
}

tweet_sentiment <- function(df_text){
  emotion <- get_nrc_sentiment(df_text)
  emotion_bars <- colSums(emotion)
  emotion_summation <- data.frame(
    count = emotion_bars,
    emotion = names(emotion_bars)
  )
  emotion_summation$emotion <- factor(emotion_summation$emotion,
                                      levels = emotion_summation$emotion[order(emotion_summation$count, decreasing = TRUE)])
  return(emotion_summation)
}

# follower count = twitter_summary()$followers_count


# mentions_screen_name: name of person who is mentioned in tweet ----------


