library(tidyverse)

data = read.csv("HeightWeight.csv")


data %>% 
  ggplot(aes(x= Height.M, y = Weight.kg))+
  geom_point(colour = "darkblue")+
  labs(title = "Height and weight of young girls",
       x = "Height",
       y = "Weight")

?geom_point

correlation <- cor(data$Height.M,
                   data$Weight.kg,
                   method = "pearson") 

summary(correlation)
# moderate positive relationship 

model <- lm(formula = Weight.kg ~ Height.M, data = data)

summary(model)


data %>% 
  ggplot(aes(x= Height.M, y = Weight.kg))+
  geom_point(colour = "darkblue")+
  geom_smooth(method = lm, se = F)+
  labs(title = "Height and weight of young girls",
       x = "Height",
       y = "Weight")



