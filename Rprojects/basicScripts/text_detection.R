library(tidyverse)
library(gtExtras)

view(mtcars)

mtcars %>% 
  mutate(model = rownames(mtcars)) %>% 
  mutate(has_M = str_detect(model, "M")) %>% 
  filter(has_M == TRUE) %>% 
  select(model, mpg, cyl, disp) %>% 
  gt() %>% 
  tab_header(title = "Cars that contain the letter M") %>% 
  cols_align(align = "left") %>% 
  gt_theme_538()

