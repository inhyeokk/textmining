# intall.pachages("pdftools")
# intall.pachages("stringr")
# intall.pachages("wordcloud")

library(pdftools)
library(stringr)
library(wordcloud)

getwd() # 현재 작업중인 디렉토리

# 다운로드 받은 pdf 파일을 객체에 저장
text <- pdf_text("RStudio.pdf") 

save(text, file = "RStudio_text.RData") # 저장

# strsplit() 함수의 결과값은 벡터가 아닌 리스트이다.
text_line <- strsplit(text, split = "\n")
text_sent <- strsplit(unlist(text_line), split = "\\. ")

text_word <- strsplit(unlist(text_sent), split=" ")
text_word <- unlist(text_word) # 리스트의 결과값을 벡터화

text_word[1:20]

text_word_main <- text_word[nchar(text_word)>0]
text_word_main

# rstudio 단어를 포함하는 모든 인덱스를 반환
which(str_detect(tolower(text_word_main), "rstudio"))

# pdf 파일 중 많이 쓰인 단어 순으로 벡터값과 그 개수를 반환
text_word_freq <- sort(table(text_word_main), decreasing = TRUE)
text_word_freq[1:10]

# 적게 쓰인 단어를 반환
tail(text_word_freq[text_word_freq==1])

# wordcloud의 시각화
# "Dark2" 팔렛트로 부터 8가지 색상을 끌어와 pal에 저
pal <- brewer.pal(8, "Dark2")

wordcloud(words = names(text_word_freq), # 벡터의 이름들, 즉 단어들
          freq = text_word_freq, # 단어의 출현 횟수
          min.freq = 5,
          max.words = 200,
          random.order = FALSE, # 많이 등장하는 단어를 중심에 위치
          rot.per = 0.1,
          scale = c(4, 0.3),
          colors = pal # pal에 저장된 8가지 색상
)