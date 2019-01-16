library(dplyr)
library(tidytext)
library(stringr)
getwd()
load("bts_rtweet.RData")

# dplyr의 arrange() 함수는 해당 변수를 순차적으로 정렬(작은 것부터);
# 시간의 경우 오래된 데이터부터 정렬
bts_text_unique %>% arrange(created_at)

bts_text_unique %>% 
  arrange(created_at) %>% 
  # words 토큰을 기본 단위로 text 문자열을 쪼개 word에 저장
  # 텍스트를 토큰화
  unnest_tokens(word, text, token = "words") %>%
  # dplyr의 slice() 함수는 특정 범위의 행(들)만 추출해서 보여주는 기능을 함
  slice(11:30) 

bts_text_unique %>% 
  arrange(created_at) %>%
  # 해시태그나 트위터 핸들의 의미는 보존하지만, 빈칸이 아닌 공백문자를
  # 기준으로 문자열을 쪼개지는 못함
  unnest_tokens(word, text, token = "regex", pattern=" ") %>%
  slice(11:30) 

# 따라서 pattern의 인자로 토큰화에서 제외시켜야할 모든 문자가 포함되어야 함
bts_text_unique %>% 
  arrange(created_at) %>%
  # 단어를 구성하는 알파벳, 숫자 및 해시태그 트위터핸들 기호를 제외한 모든 문자
  unnest_tokens(word, text, token = "regex", pattern="[^[:word:]#@]") %>%
  slice(11:30) 

unnest_regex <- "[^[:word:]#@]"
bts_word_count <- bts_text_unique %>%
  unnest_tokens(word, text, token="regex", pattern = unnest_regex) %>%
  # 빈도수를 계산하고 내림차순 정렬
  count(word, sort = TRUE)

# 'bts_word_count'는 데이터 프레임의 형식을 갖추고 있다. 변수는 두개,
# 관측값은 16,730. 즉, 트윗에서 나타나는 고유 단어의 수
bts_word_count[1:10,]

bts_word_count[41:50,]

# BTS와 관련되지 않은 데이터는 필요없으므로 제거해야함
remove_regex <- "https?://[[:word:]./]+|www\\.[[:word:]./]+|&amp;|&lt;|&gt;|&quot;"
bts_text_unique %>%
  # text 변수의 문자열에서 url 문자열 또는 HTML 특수기호 문자열을 매칭하는 정규표현식
  mutate(text = str_replace_all(text, remove_regex), "")

bts_text_unique %>%
  # text 변수의 문자열에서 해시태그, 트워터핸들이 포함된 비알파벳 문자를 제거
  mutate(text = str_replace_all(text, "[#@]?[^[:ascii:]]", ""))

bts_tidy <- bts_text_unique %>%
  mutate(text = str_replace_all(text, remove_regex, "")) %>%
  mutate(text = str_replace_all(text, "[#@]?[^[:ascii:]]", "")) %>%
  unnest_tokens(word, text, token = "regex", pattern = unnest_regex) %>%
  # Matching 연산자 %in%; tidytext 패키지는 불용어 리스트르 데이터 프레임 형식으로 제공
  filter(!word %in% stop_words$word)

bts_tidy_count <- bts_tidy %>% count(word, sort = T)

library(wordcloud)

set.seed(816)
pal <- brewer.pal(8, "Dark2")
wordcloud(words = bts_tidy_count$word,
          freq = bts_tidy_count$n,
          max.words = 200,
          random.order = FALSE,
          rot.per = 0.1,
          scale = c(4, 0.4),
          colors = pal)