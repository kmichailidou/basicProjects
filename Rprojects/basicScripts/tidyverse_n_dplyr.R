library(tidyverse)
# mutate() -> you can add and create a new variable 
# or change and existing one

# c() -> concatenation
view(starwars)
sw <- starwars %>% 
  select(name,height,mass,gender) %>% 
  rename(weight = mass) %>% 
  na.omit() %>% 
  mutate(height = height/100) %>% 
  filter(gender %in% c("male","female")) %>% 
  mutate(gender = recode(gender,
                         male = "m",
                         female = "f")) %>% 
  mutate(size = height > 1 & weight > 75,
         size = if_else(size == TRUE, "big", "small"))
