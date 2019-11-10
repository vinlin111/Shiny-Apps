
# twitter scrape by username application ----------------------------------

library(tidyverse)
library(ggplot2)
library(twitteR)
library(rtweet)
library(ggpubr)

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

twitter_sentiment <- function(user){
  t <- twitter_info(user, number_of_tweets = 10000) %>%
    filter(is_retweet == FALSE) %>%
    select("text")
  return(t)
}


# follower count = twitter_summary()$followers_count


# mentions_screen_name: name of person who is mentioned in tweet ----------


