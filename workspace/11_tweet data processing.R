# install.packages("tidytext")

library(dplyr)
library(tidytext)
getwd()
load("bts_rtweet.RData")

dim(bts_rtweet) # 데이터 프레임; 4773행; 88열

bts_rtweet[1,] # bts_rtweet 데이터 프레임의 첫번째 행 (관측치) 인덱싱 (불러오기)

bts_rtweet[,1] # bts_rtweet 데이터 프레임의 첫번째 열 (변수) 인덱싱 (불러오기)

# 데이터의 변수 선택은: 데이터 객체 이름에 $ 사인 후 변수 이름 입력
class(bts_rtweet$user_id) # 각 트윗의 사용자 아이디 -> 문자 벡터

bts_rtweet$user_id[1:10] # 첫번째 트윗 부터 열번째 트윗의 사용자 아이디 인덱스

class(bts_rtweet$text) # 문자(열) 벡터

bts_rtweet$text[1:10] # 1~10번째 트윗의 문자열 내용 인덱싱

# 데이터 처리과정을 연쇄적으로 이어주는 파이프 연산자;
# bts_rtweet에서 status_id, created_at, text라는 변수들만 남기고 나머지는 제거
bts_rtweet %>% select(status_id, created_at, text) 

bts_text <- bts_rtweet %>% select(status_id, created_at, text)

dim(bts_text) # 새로운 데이터 프레임 구조 확인

# duplicated(text) 조건에 대해 참인 행들만 남겨라;
# 해당 벡터의 값 중 중복되는 값인지 판별
bts_text %>% filter(duplicated(text)) 

# 중복되지 않는 행들만 남김; !연산자
bts_text %>% filter(!duplicated(text)) 

bts_text_unique <- bts_text %>% filter(!duplicated(text)) # 객체 할당

