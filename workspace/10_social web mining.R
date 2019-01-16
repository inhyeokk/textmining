#install.packages("httpuv")
#install.packages("rtweet")
library(httpuv)
library(rtweet)

# autheticate wia web browser
token <- create_token(
  app = "your_app",
  consumer_key = "key",
  consumer_secret = "secret"
)

iu_rtweet <- search_tweets("#keyword", n=5000, include_rts = FALSE,
                           lang = "ko")
iu_rtweet
save(keyword_rtweet, file = "keyword_rtweet.RData")