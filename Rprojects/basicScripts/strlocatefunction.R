library(tidyverse)
library(gtExtras)


starwars %>% 
  pull(name) %>% 
  str_locate(" ") %>% 
  view()



starwars %>% 
  filter(species == "Human") %>% 
  mutate("first name" = 
           str_sub(name,1,
                   str_locate(name, " ")[ ,1] -1)) %>% 
  select(name, "first name") %>% 
  gt() %>% 
  tab_header(title = "Names of starwars characters") %>% 
  cols_align(align = "left") %>% 
  gt_theme_538()

