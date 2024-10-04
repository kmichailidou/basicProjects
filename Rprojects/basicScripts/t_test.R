install.packages("patchwork")
library(tidyverse)
library(patchwork)
library(gapminder)

View(gapminder)

# in t-test we always asking question about average 

 
# Hypothesis testing : 
# H0: mean life expectancy is 50 yrs
# H1: mean life expectancy is not 50 yrs


# observation: sample data provides a mean life expectancy
# of 48.9 (in Africa). Is this statistically significant?


# mu is for population mean 
gapminder %>% 
  filter(continent == "Africa") %>% 
  select(lifeExp) %>% 
  t.test(mu = 50)


my_ttest <- gapminder %>% 
  filter(continent == "Africa") %>% 
  select(lifeExp) %>% 
  t.test(mu = 50)


# what is inside of that object
attributes(my_ttest)

# the p value of the object
my_ttest$p.value


# two sided test for difference of means
gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>% 
  t.test(lifeExp ~ continent, data = .,
         alternative = "two.sided")


 
# one sided test for difference of means
gapminder %>% 
  filter(country %in% c("Ireland", "Switzerland")) %>% 
  t.test(lifeExp ~ country, data = .,
         alternative = "less",
         conf.level = 0.95)


# paired t-test
# c(2007, 1957) -> because we want to subtract 
gapminder %>% 
  filter(year %in% c(1957, 2007) & continent == "Africa") %>% 
  mutate(year = factor(year, levels = c(2007, 1957))) %>% 
  t.test(lifeExp ~ year, data = .,
         paired = TRUE)


# Assumptions of t-test: 
# 1) Large, representative sample
# 2) Values or normally distributed
# 3) Two samples have similar variance 

var(gapminder$lifeExp[gapminder$country=="Ireland"])
var(gapminder$lifeExp[gapminder$country=="Switzerland"])


