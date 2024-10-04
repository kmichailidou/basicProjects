library(tidyverse)
library(MASS)

lm(Fertility ~ . , data = swiss) %>% 
  step(direction = "backward", trace = 0) %>% 
  summary()



