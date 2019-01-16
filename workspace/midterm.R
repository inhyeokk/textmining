# intall.pachages("stringr")
#install.packages("readr")
library(stringr)
library(readr)

bts_exam <- str_c(read_lines("text.txt"), collapse=" ")

str_length(bts_exam)
text_string <- str_c(bts_exam, collapse = " ")
str_locate_all(text_string, "BTS")

unlist(str_extract_all(text_string, "[[:punct:][]^]+")) 
