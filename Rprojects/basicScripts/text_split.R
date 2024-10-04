library(tidyverse)

starwars %>% 
  mutate(name_parts = str_split(name, " ")) %>% 
  select(name, name_parts) %>% 
  view()

