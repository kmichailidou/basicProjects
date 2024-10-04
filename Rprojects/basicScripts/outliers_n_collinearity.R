library(tidyverse)


plot(model , which = 5)


# collinearity 

mtcars %>% 
  select(mpg, disp, hp) %>% 
  cor() %>% 
  round(2)




 