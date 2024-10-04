library(tidyverse)

lm(formula = mpg ~ wt * am, data=mtcars) %>% 
  summary()

mtcars %>% 
  ggplot(aes(wt, mpg))+
  geom_point()+
  geom_smooth(method = lm, se = F)+
  theme_bw()+
  labs(title = "Fuel efficiency explained by weight of cars",
       x = "Weight of cars",
       y = "Fuel efficiency")


?fct_recode
mpg %>% 
  mutate(drv = fct_recode(drv, "2" = "f", "2" = "r")) %>% 
  lm(hwy ~ displ *  drv, data = .) %>% 
  summary()
  


