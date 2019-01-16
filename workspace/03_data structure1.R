fruits <- c("Apple", "Grapes", "Pears", "Apple")
sort(fruits) # 알파벳 순으로 정렬하여 값을 반환
table(fruits) # 리스트 내부 객체의 각 개수를 셈
unique(fruits) # 중복되는 객체 제거 후 유일한 객체 반환

fruits[4] # 리스트의 4번째 요
fruits[-4] # 4번째 제외한 모든 것
fruits[2:4] # 2 ~ 4번째째
fruits[-(2:4)] # 2 ~ 4번째 제외한 모든 
fruits[c(1,4)] # 1,4번째 요소

fruits[fruits == "Apple"] # "Apple"과 같은 글자인 요소

fruits["Apple"] # NA

fruits[fruits != "Apple"] # "Apple"을 제외한 모든 요소

fruits[fruits %in% c("Apple", "Grapes")] # %in% 는 해당 집합에 포함된 요소를 찾아냄

#----------
vector_numeric <- c(1:6)
vector_numeric # 1 ~ 6

vector_character <- c("v", "e", "c", "t", "o", "r")
vector_character

vector_logical <- c(TRUE, FALSE, FALSE, TRUE, T, F)
vector_logical

# list()
obj1 <- c("BTS", "is", "known", "as", "the", "Bangtan Boys")
obj2 <- c("And", "BTS", "is", "a", "seven-member", "South Korea", "boy band")
MyList <- list(obj1, obj2)

class(obj1) # vector(character)
class(obj2) # vector(character)
class(MyList) # list

MyList[[1]]
class(MyList[[1]]) # vector(character)
MyList[[2]]
