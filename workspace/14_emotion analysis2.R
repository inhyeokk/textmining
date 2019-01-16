# 감정분석2
#install.packages("lubridate")

library(dplyr)
library(lubridate)
library(ggplot2)

#load("bts_text_unique.RData")
bts_text_unique # 텍스트 전처리를 거친 BTS 해시태그 트윗 데이터

# 트윗 자체의 발생 빈도를 시각화
# floor_date(): 각 시간 단위에 포함되어 있는 값들을
# 같은 시간 단위 발생값으로 변환해줌
bts_text_unique %>%
  mutate(time_floor = floor_date(created_at, unit = "hour")) %>%
  count(time_floor) %>%
  ggplot(aes(x=time_floor, y=n)) + 
  geom_line() + 
  labs(x=NULL, y="Hourly Sum",
       title = "Tracing #BTS salience on Twitter",
       subtitle = "Tweets (N=4, 694) were aggregated in 1-hour intervals. Rewteets were excluded.")

# 긍정적 또는 부정적 감정 분류에 따른 어휘 빈도수를 시각화
library(tidytext)
#load("bts_tidy.RData")

bts_tidy %>%
  filter(!word %in% c("fake", "love")) %>% # 부정 어휘 중 fake love는 노래 제목이므로 제외
  inner_join(get_sentiments("bing")) %>% # 감정 어휘를 bing 사전에서 가져옴
  count(sentiment, word, sort = TRUE) %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill=sentiment)) + 
  geom_bar(stat="identity", show.legend = "free_y") + 
  facet_wrap(~sentiment, scales="free_y") + # 긍정, 부정 분류
  coord_flip()

# 감정 추이 시각화(감정 어휘들의 출현 빈도 차이를 시간 순서대로 시각화)
library(tidyr)

bts_tidy %>%
  filter(!word %in% c("fake", "love")) %>%
  mutate(time_floor = floor_date(created_at, unit = "hour")) %>%
  inner_join(get_sentiments("bing")) %>%
  count(time_floor, sentiment) %>%
  spread(sentiment, n, fill=0) %>% # time_floor의 시간 단위에 따라 negative와 positive 변수를 각각 만들어 그 빈도수를 정리
  mutate(sentiment = positive - negative) %>% # 두 변수의 차이값을 sentiment에 할당
  ggplot(aes(x=time_floor, y=sentiment)) + # 그 값을 y축에, 시간 단위를 x축에 위치시키면 시간의 흐름에 따라 빈도수를 그래프화
  geom_col() + 
  scale_x_datetime(date_breaks = "1 day", date_labels = "%b %d")
