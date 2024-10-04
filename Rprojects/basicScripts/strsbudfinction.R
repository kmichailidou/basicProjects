library(tidyverse)
library(gtExtras)



mtcars %>% 
  mutate(model = rownames(mtcars)) %>% 
  mutate("short name" = str_sub(model, 1,3)) %>% 
  select(model, "short name", mpg, cyl, disp) %>% 
  gt() %>% 
  tab_header(title = "Models and shortened names") %>% 
  cols_align(align = "left") %>% 
  gt_theme_538()


