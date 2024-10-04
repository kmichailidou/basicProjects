# starwars 

library(tidyverse)
View(starwars)

# Single numeric variable
# histogram, density plot, box plot, violin plot

starwars %>% 
  select(name, height) %>% 
  View()


# one or more categorical variable
# barplot, stacked barplot, grouped barplot, percentage barplot

starwars %>% 
  select(name, eye_color, gender) %>% 
  View()


# one numeric and two categorical variables

# density plot of a numeric variable 
# 1) (disagrerated by one categorical variable)
# 2) (disagrerated by two categorical variables)

# boxplot of a numeric variable
# 1) (disagregated by one categorical variable)
# 2) (disagregated by two categorical variables)

starwars %>% 
  select(name, eye_color, gender, height) %>% 
  View()


# two numeric and one categorical
# scatter plot of two numeric variables
# 1) (with a smoothed linear model and Standard Error margins)
# 2) (disagregated by a categorical variable using colour)
# 3) (disagregated by a categorical variable using facets and colour)


starwars %>% 
  select(name, height, mass, sex) %>% 
  View()




library(gapminder)
View(gapminder)


gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>% 
  filter(gdpPercap < 30000) %>% 
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             size = pop,
             color = year))+
  geom_point()+
  facet_wrap(~continent)+
  labs(title = "Life expectancy explained by GDP per capita",
       x = "GDP per capita",
       y = "Life expectancy")









