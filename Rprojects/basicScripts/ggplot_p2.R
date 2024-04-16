library(tidyverse)
# names() gives us the names of the variables of the dataset
names(mpg)


mpg %>% 
  filter(hwy <35) %>% 
  ggplot(aes(x = displ,
             y = hwy,
             colour = drv))+
  geom_point()+
  geom_smooth(method = lm,
              se = F)+
  labs(x = "Engine size",
       y = "MPG on the Highway",
       title = "Fuel efficiency")+
  theme_minimal()+
  ggsave("MPH_hwy.jpg")
