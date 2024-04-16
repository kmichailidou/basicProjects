library(tidyverse)
View(starwars)

# dim is for data set dimensions
dim(starwars)

# str is for structure of a data set
str(starwars)

# gilmpse comes with the tidyverse
# is for presenting data more understandable (in console)
glimpse(starwars)

# in R dbl variable type is something similar to numeric

head(starwars)
tail(starwars)

starwars$name

# attach is for not mentioning every time the name of the data set
# as the previous command in line 19
attach(starwars)

# names gives  the names of variables
names(starwars)

# here length gives the length of the data columns
length(starwars)

# class gives the class type of the column -> "character"
class(hair_color)

# gives the length of the rows of that color
length(hair_color)

# unique gives the unique values of the column 
unique(hair_color)

# table counts the variable how many times are in the column
table(hair_color)

# sort is for sorting the variables from less to many 
sort(table(hair_color))

# here it gives another "data set" with sorted variables from that
# particular column
View(sort(table(hair_color), decreasing = TRUE))

# it makes a bar plot with all of the variables sorted 
barplot(sort(table(eye_color), decreasing = TRUE))


starwars %>% 
  select(hair_color) %>% 
  count(hair_color) %>% 
  arrange(desc(n)) %>% 
  View()
  
# rows , columns 
starwars[ , ]

View(starwars[is.na(hair_color), ])

is.na(hair_color)

class(height)
length(height)
summary(height)
boxplot(height)
hist(height)


