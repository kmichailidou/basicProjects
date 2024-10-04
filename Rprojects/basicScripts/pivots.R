library(tidyverse)

?pivot_wider
?Orange

View(Orange)

or2 <- Orange %>% 
  pivot_wider(names_from = "age",
              values_from = "circumference") %>% 
  View()


or2 <- Orange %>% 
  pivot_longer(cols = 2:8,
               names_to = "AGE",
               values_to = "CIRCUMFERENCE") %>% 
  View()


