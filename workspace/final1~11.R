# 과제2
library(tidytext)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(ggplot2)

sentiments %>% group_by(lexicon) %>% summarise(n = n())
table(sentiments$lexicon)
sentiments %>% count(lexicon, sort = T)
count(sentiments, lexicon)
summarise(sentiments, n=n())

sejong <- "Sejong reinforced Confucian policies and executed major ‘legal amendments’ (공법; 貢法). He also personally created and promulgated the Korean alphabet Hangul,[2][3] encouraged advancements of scientific technology, and instituted many other efforts to stabilize and improve prosperity. He dispatched military campaigns to the north and instituted the Samin policy (사민정책; 徙民政策) to attract new settlers to the region. To the south, he subjugated Japanese pirates and captured Tsushima Island (also known as Daema Island in the Korean language)."

str_length(unlist(str_split(sejong, " ")))
length(unlist(str_split(sejong, "\\.")))
length(str_split(sejong, " "))
length(unlist(str_extract_all(sejong, boundary("word"))))
str_length(str_split(sejong, " "))

sejong_sents <- str_extract_all(sejong, boundary("sentence")) %>%
  unlist()
class(sejong_sents)
sejong_sents

sejong_sents <- str_extract_all(sejong, boundary("sentence"))
class(sejong_sents)

sejong_sents <- unlist(str_extract(sejong, boundary("sentence")))
class(sejong_sents)

sejong_sents <- str_extract_all(sejong, boundary("word"))
class(sejong_sents)

sejong_sents <- str_split(sejong, " ") %>% unlist()
class(sejong_sents)
sejong_sents

sejong_sents_df <- data_frame(line=1:4, text=sejong_sents)

sejong_tidy <- sejong_sents_df %>% unnest_tokens(word, text, token = "words")
sejong_tidy
sejong_words <- sejong_tidy %>% unnest_tokens(word, text, token = "regex", pattern="[^[:word:]#@]")
sejong_words
