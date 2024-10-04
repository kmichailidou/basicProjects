library(tidyverse)
View(msleep) 

?msleep

msleep %>% 
  drop_na(sleep_rem) %>% 
  group_by(vore) %>% 
  summarise('Average Total Sleep' = mean(sleep_total),
            'Maximum rem sleep' = max(sleep_rem)) %>% 
  view()


