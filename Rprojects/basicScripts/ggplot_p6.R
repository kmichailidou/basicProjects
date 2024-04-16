library(tidyverse)
names(msleep)

# single categorical -> barchart
# single numeric -> histogram
# boxplot 


# a numeric and  a categorical variable

msleep %>% 
  drop_na(vore) %>% 
  ggplot(aes(vore, sleep_total))+
  geom_boxplot()+
  coord_flip()+
  theme_bw()


msleep %>% 
  drop_na(vore) %>% 
  ggplot(aes(sleep_total))+
  geom_density()+
  facet_wrap(~vore)+
  theme_bw()


msleep %>% 
  drop_na(vore) %>% 
  filter(vore == "herbi" | vore == "omni") %>% 
  filter(vore %in% c("carni", "omni")) %>% 
  ggplot(aes(sleep_total, fill = vore))+
  geom_density(alpha = 0.2)+
  theme_bw()





