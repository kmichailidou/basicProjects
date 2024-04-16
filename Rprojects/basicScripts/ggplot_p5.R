library(tidyverse)
view(Orange)


# two numeric variables and one categorical variable
# Tree column has numbers which matches for a tree e.g oak tree

Orange %>% 
  filter(Tree != 2) %>% 
  ggplot(aes(age, circumference))+
  geom_point()+
  geom_smooth()+
  facet_wrap(~Tree)+
  theme_bw()+
  labs(title = "Tree age and circumference")


Orange %>% 
  filter(Tree != "1" & Tree != "2") %>% 
  ggplot(aes(age, circumference, colour = Tree))+
  geom_point(size = 5, alpha = 0.3)+
  geom_line(size = 1)+
  theme_minimal()+
  labs(title = "Tree age and circumference")
  

