library(tidyverse)
install.packages("gtExtras")
library(gt)
library(gtExtras)


iris %>% 
  gt_plt_summary()



mtcars %>% 
  group_by(cyl) %>% 
  summarise(Median = round(median(mpg),1),
            Mean = round(mean(mpg),1),
            Distribution = list(mpg)) %>% 
  gt() %>% 
  gt_plt_dist(Distribution) %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Miles per gallon statistics by car cylinder number")
