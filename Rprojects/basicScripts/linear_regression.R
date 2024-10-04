library(tidyverse)

head(cars, 10)

# we use the . to lm be calculated correctly,
# otherwise will be calculated uncorrectly
cars %>% 
  lm(dist ~ speed, data = .) %>% 
  summary()

# in this case, we don't use the pipe operator,
# so we have to say what data set should use to calculate lm
mod <- lm(dist ~ speed, data = cars)
mod
summary(mod)

attributes(mod)
mod$residuals
hist(mod$residuals)

new_speeds <- data.frame(speed = c(10,15,20))

predict(mod, new_speeds) %>% round(1)
# 1 = 10, 2 = 15 and 3 = 20

cars %>% 
  lm(dist ~ speed, data = .) %>% 
  predict(data.frame(speed = c(10,15,20))) %>% 
  round()


