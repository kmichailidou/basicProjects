library(tidyverse)

dataset = read.csv("Categorical_Example.csv")

dataset %>% 
  ggplot(aes(x = Major, y = Income))+
  geom_boxplot(fill = "steelblue",alpha = 0.5)+
  labs(title = "Boxplot of Income",
       x = "Major",
       y = "Income")


dataset %>% 
  aov(Income ~ Major, data = .) %>% 
  summary()
