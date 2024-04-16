require(tidyverse)
data()
View(starwars)
sw <- starwars %>% 
  select(name, height, mass) %>% 
  rename(weight = mass)
