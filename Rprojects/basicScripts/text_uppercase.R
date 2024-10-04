library(tidyverse)
library(gtExtras)


starwars %>% 
  select(name, species) %>% 
  mutate(species = str_to_upper(species)) %>% 
  gt() %>% 
  tab_header(title = "Species variable now in upper-case") %>% 
  cols_align(align = "left") %>% 
  gt_theme_538()
