library(tidyverse)
View(starwars)


# bar charts for two categorical variables
# panel.grid.major = element_blank() -> removing the grid lines 
# position = "dodge" -> is for presenting the results in different bars
# instead of one be placed on top of the other

starwars %>% 
  filter(hair_color == "black" | hair_color =="brown") %>% 
  drop_na(sex) %>% 
  ggplot(aes(hair_color, fill = sex))+
  geom_bar(position = "dodge",
           alpha = 0.5)+
  theme_bw()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())+
  labs(title = "Gender and Hair colour",
       x = "Hair colour",
       y = "Number")


starwars %>% 
  filter(hair_color %in% c("black","brown")) %>% 
  drop_na(sex) %>% 
  ggplot(aes(x = sex))+
  geom_bar(aes(fill = sex), alpha = 0.5)+
  facet_wrap(~ hair_color)+
  theme_bw()+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "none")+
  labs(title = "Gender and Hair colour",
       x = "Hair colour",
       y = "Number")


