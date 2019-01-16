# 과제2
library(tidytext)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(ggplot2)

load("SK_rtweet_606.RData")

unnest_regex <- "[^[:word:]#@]"
remove_regex <- "https?://[[:word:]./]+|www\\.[[:word:]./]+|&amp;|&lt;|&gt;|&quot;"

SK_rtweet

SK_rtweet_tidy <- SK_rtweet %>%
  select(text, created_at) %>%
  mutate(text = str_replace_all(text, remove_regex, "")) %>%
  unnest_tokens(word, text, token="regex", pattern=unnest_regex) %>%
  anti_join(stop_words) %>%
  filter(!str_detect(word, "[#@]"))

SK_rtweet_tidy %>%
  inner_join(bing) %>%
  group_by(sentiment) %>% # sentiment의 범주 구분에 따라 데이터를 그룹화
  count(word, sort=T) %>% # word의 출현 빈도수 계산 및 내림차순 정렬
  top_n(10) %>% # 출현빈도수 상위 10개의 단어를 각 데이터 그룹에서 추출
  ggplot(aes(reorder(word, n), n, fill=sentiment)) + 
  geom_bar(stat="identity", show.legend = FALSE) + 
  facet_wrap(~sentiment, scales="free_y") + 
  labs(y="Contribution to sentiment", x=NULL) + 
  coord_flip()

