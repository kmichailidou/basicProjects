library(tidyverse)
library(gapminder)


view(gapminder)


gapminder %>% 
  separate(col = year,
           into = c("century", "year"),
           sep = 2)


gapminder1 %>% 
  unite(col = date,
        century, year,
        sep = "") %>% 
  view()




