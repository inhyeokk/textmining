10 + 5
10 - 5

c(1,3,5) # 각 요소를 벡터로 결합

1:5 # 1 ~ 5

seq(1, 5, by=2) # 1부터 5까지 2씩 증가

rep(1:5, times=3) # 1부터 5까지 3번 반복

rep(1:5, each=3) # 1부터 5까지 각각 3번 반복

a <- 10
a - 5

class <- "text mining"
print(class)

fruits <- c("Apple", "Grapes", "Pears", "Apple")
sort(fruits) # 알파벳 순으로 정렬하여 값을 반환
table(fruits) # 리스트 내부 객체의 각 개수를 셈
unique(fruits) # 중복되는 객체 제거 후 유일한 객체 반환

# 문자열 데이터는 문자 벡터가 될 수 있다.
hello <- c("Hello", "world", "is", "good!")
print(hello)
paste(hello, collapse = ",") # ','문자로 객체를 이어붙입

hello <- c("Hello", "world", "is", "good!")
hello_paste <- paste(hello, collapse = " ")
strsplit(hello_paste, split = " ")

# nchar: 문자 수 및 바이트 수 계산
nchar("data")
nchar("bigdata")
nchar("big data")
nchar("big, data")

# strsplit() 문장을 단어로 분류
sentl <- "Text mining begins with preprocessing and tokenization"
# 공백을 기준으로 문장을 7개의 단어로 나눕니다.
sentl_split <- strsplit(sentl, split = " ")
sentl_split # 변환된 단어를 리스트 객체로 변환해 출력
sentl_split[[1]] # 단어 분류의 첫번째 벡터를 출력
sentl_split[[1]][5] # 첫번째 벡터의 5번째 요소를 출력

# paste(); 단어를 다시 결합
sent2 <- paste(sentl_split[[1]], collapse = " ")
paste(sentl_split[[1]], collapse = "/")
sent2

# tolower(), toupper()
sentence <- "Text mining is easy to learn"
toupper(sentence)
tolower(toupper(sentence))

# 대소문자의 구분
word1 <- "TEXT"
word1

word2 <- "Text"
word2

word1 == word2 # FALSE

?c # 특정함수의 도움말보기
help.search("split") # 함수
help(package = "stringr") # 패키지 도움말
