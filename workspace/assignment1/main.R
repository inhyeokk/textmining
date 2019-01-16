#install.packages("pdftools")
# intall.pachages("stringr")
#install.packages("dplyr")
library(pdftools)
library(stringr)
library(dplyr)

text <- pdf_text("RStudio.pdf")
text_tidy_word <- str_c(text, collapse = " ") %>%
  str_trunc(3671, side = "right") %>%
  str_replace_all("[[:space:]]{1,}", " ") %>%
  str_replace_all("[^[:ascii:]]+", " ") %>%
  tolower() %>%
  str_replace_all("['][sS] ", " ") %>%
  str_replace_all(" u\\.s\\. ", " usa ") %>%
  str_replace_all(" r\\.&b\\. ", " rnb ") %>%
  str_replace_all("\\[[[:digit:]]+\\]|\\([[:digit:]]+\\)", "") %>%
  str_replace_all("[[:punct:]^]+", "") %>%
  str_replace_all("[[:digit:]]+","") %>%
  str_replace_all("[[:space:]]{1,}", " ") %>%
  str_split(" ") %>%
  unlist()
text_tidy_word_freq <- text_tidy_word %>%
  table() %>%
  sort(decreasing = TRUE)
text_tidy_word_freq[1:50]

library(wordcloud)

pal <- brewer.pal(8, "Dark2")
set.seed(405)
wordcloud(words = names(text_tidy_word_freq),
          freq = text_tidy_word_freq,
          min.freq = 1,
          max.words = 50,
          random.order = FALSE,
          rot.per = 0.1,
          scale = c(4, 0.3),
          colors = pal)
