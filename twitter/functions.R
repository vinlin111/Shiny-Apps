
# twitter scrape by username application ----------------------------------

library(tidyverse)
library(ggplot2)
library(twitteR)
library(rtweet)
library(ggpubr)

twitter_info <- function(username, number_of_tweets){
  info <- get_timeline(username, n=number_of_tweets)
  return(info)
}

twitter_summary <- function(username){
  user <- lookup_users(username)
  user_data <- user %>%
    select("user_id",
           "screen_name",
           "source",
           "followers_count",
           "verified",
           "friends_count")
  return(user_data)
}


# follower count = twitter_summary()$followers_count