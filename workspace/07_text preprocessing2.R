# intall.pachages("stringr")

library(stringr)

fns <- c("fan", "fen", "fin", "fon", "fun")
unlist(str_extract_all(fns, "f[aeiou]n"))

fnx <- c("fan", "fin", "fun", "f0n", "f.n", "fln", "fain")
unlist(str_extract_all(fnx, "f[aeiou]n"))

triplets <- c("bts", "the", "BTS", "The", "010", "070", ":~", "^^;")
#연속된 3개의 소문자
unlist(str_extract_all(triplets, "[a-z][a-z][a-z]")) 

# 연속된 3개의 대문자
unlist(str_extract_all(triplets, "[A-Z]{3}")) 

# 대문자로 시작되고 그 다음 소문자 1회 이상
unlist(str_extract_all(triplets, "[A-Z][a-z]+")) 

# 연속된 숫자 1회 이상이고 숫자로 종결
unlist(str_extract_all(triplets, "[0-9]+$")) 

# 문자 및 숫자 이외의 문자가 1회 이상 매칭되는 모든 요소
unlist(str_extract_all(triplets, "[^a-zA-Z0-9]{1,}"))

# 문자/숫자/캐럿 1회 이상 연결되는 문자열 매칭
unlist(str_extract_all(triplets, "[a-zA-Z0-9^]+")) 

unlist(str_extract_all(fnx, "f\\.n"))
unlist(str_extract_all(fnx, "f[.]n"))

# 3개의 임의의 숫자 연결된 패턴
unlist(str_extract_all(triplets, "\\d{3}"))

# 1개 이상 연속된 비 숫자 패턴
unlist(str_extract_all(triplets, "\\D+"))

# 1개 이상 연속된 문자 또는 숫자
unlist(str_extract_all(triplets, "\\w+"))

# 1개 이상 연속된 문자, 숫자 이외의 문자
unlist(str_extract_all(triplets, "\\W+"))

# 1개 이상 연속된 공백
unlist(str_extract_all(triplets, "\\s+"))

# 1개 이상 연속된 비공백 문자
unlist(str_extract_all(triplets, "\\S+"))

# 1개 이상의 연속된 소문자
unlist(str_extract_all(triplets, "[[:lower:]]+"))

# 1개 이상의 연속된 소문자
unlist(str_extract_all(triplets, "[[:alpha:]]+"))

# 1개 이상 3개 이하로 연속된 숫자
unlist(str_extract_all(triplets, "[[:digit:]]{1,3}"))

# [:punct:] 리터럴 문자 캐럿 "^" "~"을 매칭하지 않음
unlist(str_extract_all(triplets, "[[:punct:]~^]+"))

# 모든 단일 소문자/구두점
unlist(str_extract_all(triplets, "[[:lower:][:punct:]]"))

#-------------------------------------------------
# 위키피디아 텍스트의 어휘 빈도수 재분석
text <- pdf_text("RStudio.pdf") 

# 문자 벡터 text를 단일 문자열로 축소
text_string <- str_c(text, collapse = " ")

# 문자열에서 "references" 패턴의 위치를 찾음
str_locate_all(tolower(text_string), "references")

# 문자열을 줄일 수 있다. 해당 위치에서 오른쪽의 문자열을 삭제
text_trunc <- str_trunc(text_string, 31828, side = "right")

# 하나 이상의 공백을 하나의 공백 문자로 변경
text_nospace <- str_replace_all(text_trunc, "[[:space:]]{1,}", " ")

# 모든 영어 이외의 문자 추출(선행 문자 집합과 적어도 1번 이상 일치)
str_extract_all(text_nospace, "[^[:ascii:]]{1,}")

# 영어 이외의 문자를 ""문자로 변경
text_eng <- str_replace_all(text_nospace, "[^[:ascii:]]", "")
text_eng_lower <- tolower(text_eng)

# 제거할 구두점 확인
unlist(str_extract_all(text_eng_lower, "[[:punct:]]+"))[1:100]

# 제거할 구두점 확인, "*"는 선행 패턴과 0번 이상 일치
unlist(str_extract_all(text_eng_lower, "[[:graph:]]*[[:punct:]]{1,}[[:graph:]]+"))[1:100]

# 패턴을 바꾸기 전에 원하는 패턴과 일치하는지 항상 먼저 확인하세요
unlist(str_extract_all(text_eng_lower, "[']s "))

# 패턴을 하나의 공백 문자로 바꾸세요
text_noapos <- str_replace_all(text_eng_lower, "[']s ", " ")
str_extract_all(text_noapos, "u\\.s\\. | r\\&b ")

text_usa <- str_replace_all(text_noapos, " u\\.s\\. ", " usa ")
text_rnb <- str_replace_all(text_usa, " r\\&b ", " rnb ")
str_extract_all(text_rnb, " usa | rnb ")

str_trunc(text_rnb, 1000)

str_extract_all(text_rnb, "\\[\\d+\\]|\\(\\d+\\)")

text_nocite <- str_replace_all(text_rnb, "\\[[[:digit:]]+\\]|\\([[:digit:]]+\\)", "")

unlist(str_extract_all(text_nocite, "[[:graph:]]*[[:punct:]]{1,}[[:graph:]]*"))[1:100]

text_nopunct <- str_replace_all(text_nocite, "[[:punct:]^]+", "")
str_trunc(text_nopunct, 1000)

# 제거할 숫자 확인
# 단어를 형성하기 위해 숫자 뒤에 오는 문자를 제거하지 않음
# 따라서 숫자는 공백이나 문자가 뒤따라야 함
unlist(str_extract_all(text_nopunct, " [[:digit:]]+[[:space:]]?[[:alpha:]]*"))[1:100]

# 모든 숫자 제거
text_nonum <- str_replace_all(text_nopunct, "[[:digit:]]+", "")
str_trunc(text_nonum, 1000)

# 공백 삭제 과정을 반복
text_nospace <- str_replace_all(text_nonum, "[[:space:]]{1,}", " ")

# 공백에 따른 단어 구분
text_tidy_word <- unlist(str_split(text_nospace, " "))
# 각 단어 출현 빈도 수에 따른 내림차순 정렬
text_tidy_word_freq <- sort(table(text_tidy_word), decreasing = TRUE)
text_tidy_word_freq[1:50]

library(wordcloud)

pal <- brewer.pal(8, "Dark2")
set.seed(405)
wordcloud(words = names(text_tidy_word_freq), # 벡터의 이름들, 즉 단어들
          freq = text_tidy_word_freq, # 단어의 출현 횟수
          min.freq = 5,
          max.words = 500,
          random.order = FALSE, # 많이 등장하는 단어를 중심에 위치
          rot.per = 0.1,
          scale = c(4, 0.3),
          colors = pal # pal에 저장된 8가지 색상
)