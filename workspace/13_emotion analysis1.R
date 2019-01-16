# 감정분석
library(tidytext)
library(dplyr)
# install.packages("ggplot2")
library(ggplot2)
bing <- get_sentiments("bing") # bing 감정사전

text <- data_frame(word = c("holidays", "make", "me", "happy", "but"
                            , "this", "song", "is", "sad"))
lexicon <- data_frame(word = c("happy", "sad", "holiday", "funeral"), 
                      sentiment = c("positive", "negative", "positive", 
                                    "negative"))
inner_join(text, lexicon) # tidy 데이터간 공통 어휘를 골라 추가

# load("bts_tidy.RData")
bts_tidy # 트윗 데이터의 tidy data frame

bts_tidy %>%
  inner_join(bing) %>%
  count(sentiment, sort=T) # sentiment 변수 요소 출현 빈도수 계산 및 내림차순 정렬

bts_tidy %>%
  inner_join(bing) %>%
  group_by(sentiment) %>% # sentiment의 범주 구분에 따라 데이터를 그룹화
  count(word, sort=T) %>% # word의 출현 빈도수 계산 및 내림차순 정렬
  top_n(10) %>% # 출현빈도수 상위 10개의 단어를 각 데이터 그룹에서 추출
  ggplot(aes(reorder(word, n), n, fill=sentiment)) + 
  geom_bar(stat="identity", show.legend = FALSE) + 
  facet_wrap(~sentiment, scales="free_y") + 
  labs(y="Contribution to sentiment", x=NULL) + 
  coord_flip()
