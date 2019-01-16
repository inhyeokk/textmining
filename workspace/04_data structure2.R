# list()
obj1 <- c("BTS", "is", "known", "as", "the", "Bangtan Boys")
obj2 <- c("And", "BTS", "is", "a", "seven-member", "South Korea", "boy band")
MyList <- list(obj1, obj2)

class(MyList[2]) # list
MyList[2] # 6개의 요소를 가지는 리스트 객체

class(MyList[[2]]) # vector_character
MyList[[2]]

unlist(MyList[2]) # 리스트 객체를 벡터 객체로 변환

#unlist()
paragraph <- paste(MyList[[1]], MyList[[2]], collapse = " ") # 두 벡터를 연결
paragraph

para_list <- strsplit(paragraph, split = " ") # 리스트 객체를 반환
para_list

class(para_list) # list

para_vector <- unlist(para_list) # 리스트 -> 벡터
para_vector

class(para_vector) # character

# "abcde", 'abcde' 따옴표의 일치

library(stringr)
paragraph

# str_length()와 nchar()는 동일한 메소드임
str_length(paragraph)
nchar(paragraph)

para_vector[1:10] # 문자 벡터의 처음 10개 요소
str_length(para_vector[1:10]) #각 벡터의 문자 길이를 반환

# 문자 길이가 3보다 큰 벡터를 반환
para_vector[str_length(para_vector) > 3][1:20]


# str_split()
paragraph

strsplit(paragraph, split = " ") # 문자열 벡터를 나눔

# str_c()는 paste()와 동일한 메소드임
para_vector
paste(para_vector, collapse = " ") # 문자 벡터를 문자열로 연결
str_c(para_vector, collapse = " ") # 동

# str_detect()
para_vector
str_detect(para_vector, "a") # "a"를 포함하는 문자 벡터 반환

which(str_detect(para_vector, "a")) # TRUE의 인덱스만 반

# str_view_all()
para_vector

# a와 매칭된 문자를 화면에 보여줌
str_view_all(para_vector, "a")
