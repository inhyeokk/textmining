# 과제2
library(tidytext)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(ggplot2)

load("dt_rtweet.RData")

dt_text <- dt_rtweet %>% 
  select(status_id, created_at, text)

dt_text_unique <- dt_text %>%
  filter(!duplicated(text))

dt_tidy <- dt_text_unique %>%
  mutate(text = str_replace_all(text, remove_regex, "")) %>%
  mutate(text = str_replace_all(text, "[#@]?[^[:ascii:]]", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = unnest_regex) %>%
  filter(!word %in% stop_words$word)

dt_tidy %>%
  filter(!word %in% c("trump", "great")) %>%
  mutate(time_floor = floor_date(created_at, unit = "hour")) %>%
  inner_join(get_sentiments("bing")) %>%
  count(time_floor, sentiment) %>%
  spread(sentiment, n, fill=0) %>%
  mutate(sentiment = positive - negative) %>%
  ggplot(aes(x=time_floor, y=sentiment)) +
  geom_col() + 
  scale_x_datetime(date_breaks = "1 day", date_labels = "%b %d")