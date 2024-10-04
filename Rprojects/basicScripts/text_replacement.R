library(tidyverse)
library(gtExtras)


starwars %>% 
  select(name, species) %>% 
  mutate(species = str_replace_all(
    species,c("Human" = "Homo sapiens",
              "Droid" = "Automation"))) %>% 
  gt() %>% 
  tab_header(title = "Improved species names") %>% 
  cols_align(align = "left") %>% 
  gt_theme_538()

