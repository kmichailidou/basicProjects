library(tidyverse)

for(i in 1:5){
  print(starwars$name[i])
}


for(i in 1:length(starwars$height)){
  print(starwars$height[i])
}



# create an empty vector
taliness <- vector(
  mode = "numeric",
  length = 5
)

# add data points to new vector
for (i in 1:5) {
  taliness[i] <- starwars$height[i]/100
}

#check new vector
taliness



# Creating a loop
for(x in starwars$name) {
  print(x)
  if(x == "Darth Vader"){
    break
  }
}



# Skip a data point
for(x in starwars$name) {
  if(x == "C-3P0"){
    next
  }
  print(x)
  if (x == "Darth Vader") {
    break
  }
}



# Concatenate and print

for(i in 1:5) {
  cat("The height of", starwars$name[i],"is",
      taliness[i], "meters \n")
}







