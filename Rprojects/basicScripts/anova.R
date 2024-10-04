library(tidyverse)
library(patchwork)
library(gapminder)
library(forcats)


head(gapminder)

# create a data set to work with
gapdata <- gapminder %>% 
  filter(year == 2007 & 
           continent %in% c("Americas", "Europe", "Asia")) %>% 
  select(continent, lifeExp)



# take a look at the distribution of means

gapdata %>% 
  group_by(continent) %>% 
  summarise(Mean_life = mean(lifeExp)) %>% 
  arrange(Mean_life)

# Research question: Is this life expectancy 
# in these three continents different

# hypothesis testing: 
# H0: Mean life expectancy is the same
# H1: Mean life expectancy is not the same

# Observation: 
# Difference in mean is observed in the sample data,
# but is this statistically significant (alpha = 0.05)

# Create ANOVA model 

gapdata %>% 
  aov(lifeExp ~ continent, data= .) %>% 
  summary()


aov_model <- gapdata %>% 
  aov(lifeExp ~ continent, data = .)


# is this significance being driven by a particular continent?

# TukeyHSD() -> HSD stands for Honesty Significant Difference
gapdata %>% 
  aov(lifeExp ~ continent, data = .) %>% 
  TukeyHSD() #%>% 
  plot()


# the difference between Asia and the Americas
# has adjusted p value of 0.14 (not significant)
# and a 95% CI that overlaps 0









