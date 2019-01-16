#install.packages("pdftools")
# intall.pachages("stringr")
library(pdftools)
library(stringr)

text <- pdf_text("RStudio.pdf")
# 문자 벡터 text를 단일 문자열로 연결
text_string <- str_c(text, collapse = " ") 

# 문자열에서 "references" 패턴의 위치를 탐색
str_locate_all(tolower(text_string), "references")

# 문자열을 줄일 수 있음. 해당 위치에서 오른쪽의 문자열을 삭제
text_trunc <- str_trunc(text_string, 3671, side = "right")

# 하나 이상의 공백을 하나의 공백 문자로 변경(공백을 줄임)
text_nospace <- str_replace_all(text_trunc, "[[:space:]]{1,}", " ")

# 영어 이외의 문자 추출
str_extract_all(text_nospace, "[^[:ascii:]]{1,}")

text_eng <- str_replace_all(text_nospace, "[^[:ascii:]]+", " ")

text_eng_lower <- tolower(text_eng)

# 텍스트에서 모든 구두점 추출
unlist(str_extract_all(text_eng_lower, "[[:punct:]]+"))[1:100]

# 제거할 구두점 확인
# "*"는 선행 패턴과 0번 이상 일치함
unlist(str_extract_all(text_eng_lower, "[[:graph:]]*[[:punct:]]{1,}[[:graph:]]+"))[1:100]

unlist(str_extract_all(text_eng_lower, "[[:alpha:]]+[''][sS] "))

text_noapos <- str_replace_all(text_eng_lower, "['][sS] ", " ")
str_extract_all(text_noapos, " u\\.s\\. | r\\&b ")

text_usa <- str_replace_all(text_noapos, " u\\.s\\. ", " usa ")
text_rnb <- str_replace_all(text_noapos, " r\\.&b\\. ", " rnb ")
str_extract_all(text_rnb, " usa | rnb")

str_trunc(text_rnb, 1000)

unlist(str_extract_all(text_rnb, "\\[\\d+\\]|\\(\\d+\\)"))[1:50]

text_nocite <- str_replace_all(text_rnb, "\\[[[:digit:]]+\\]|\\([[:digit:]]+\\)", "")

unlist(str_extract_all(text_nocite, "[[:graph:]]*[[:punct:]]{1,}[[:graph:]]*"))[1:50]

text_nopunct <- str_replace_all(text_nocite, "[[:punct:]^]", "")

# 제거할 숫자 확인
unlist(str_extract_all(text_nopunct, " [[:digit:]]+[[:space:]]?[[:alpha:]]*"))[1:50]

# 모든 숫자 제거
text_nonum <- str_replace_all(text_nopunct, "[[:digit:]]+","")

text_nospace <- str_replace_all(text_nonum, "[[:space:]]{1,}", " ")

text_tidy_word <- unlist(str_split(text_nospace, " "))
text_tidy_word_freq <- sort(table(text_tidy_word), decreasing = TRUE)
text_tidy_word_freq[1:50]

#----------------------------------------------
library(wordcloud)

pal <- brewer.pal(8, "Dark2")
set.seed(405)
wordcloud(words = names(text_tidy_word_freq),
          freq = text_tidy_word_freq,
          min.freq = 2,
          max.words = 500,
          random.order = FALSE,
          rot.per = 0.1,
          scale = c(4, 0.3),
          colors = pal)

#---------------------------------------------
#install.packages("tm")
library(tm)

stopwords("en")[1:10]
length(stopwords("en"))

stopwords("SMART")[1:10]
length(stopwords("SMART"))

text_words_nostop <- text_tidy_word[!text_tidy_word %in% stopwords("SMART")]
sort(table(text_words_nostop), decreasing=T)[1:50]

# 불용어 제외한 wordcloud
text_words_nostop_freq <- sort(table(text_words_nostop), decreasing=T)
wordcloud(words = names(text_words_nostop_freq),
          freq = text_words_nostop_freq,
          min.freq = 1,
          max.words = 1000,
          random.order = FALSE,
          rot.per = 0.1,
          scale = c(4, 0.3),
          colors = pal)
