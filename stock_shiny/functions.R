retrieve_stock_info <- function(stock_symbol, period_of_days){
  date_interval <- Sys.Date() - period_of_days
  stock_info <- tq_get(stock_symbol %>% as.character(),
                       from = date_interval)
  return(stock_info)
}