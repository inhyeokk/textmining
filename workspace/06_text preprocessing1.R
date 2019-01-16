# intall.pachages("pdftools")
# intall.pachages("stringr")

library(pdftools)
library(stringr)

# 다운로드 받은 pdf 파일을 객체에 저장
text <- pdf_text("RStudio.pdf") 

class(text) # charecter

unlist(str_extract_all(text[1], pattern = " "))

text_token <- str_split(unlist(text), pattern = " ")
unlist(text_token)

sent_trim <- unlist(text_token)[str_length(unlist(text_token))>0]
sent_trim[1:30]

# 문자열 객체가 먼저 오고 정규식의 지정된 패턴이 뒤따름
unlist(str_extract_all(text[1], pattern = " the "))

# 정규식은 대소문자를 구별하므로 아무것도 일치하지 않음
str_extract_all(text[1], " THE ")

# 모든 숫자는 리터럴 문자이다.
str_extract_all(text[1], "2016")

# t ~ e로 구성된 문자를 반환, 하나의 점'.'은 하나의 단일문자와
# 일치하므로 "the", "tee"는 반환, "three"는 X
unique(unlist(str_extract_all(sent_trim, "t.e")))

dots_words <- c("e.g", "eng", "e g", "e-g")
unlist(str_extract_all(dots_words, "e.g"))

# e.g만 찾기 위해서 \\. 사용
unlist(str_extract_all(dots_words, "e\\.g"))
