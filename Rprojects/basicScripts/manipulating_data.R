library(tidyverse)

glimpse(msleep)
View(msleep)

# rename a variable
msleep

msleep %>% 
  rename("conserv" = "conservation")


# reorder variables
# everything() is for the rest of the columns in no order 
msleep %>% 
  select(vore, name, everything())


# change a variable type
class(msleep$vore)

msleep$vore <- as.factor(msleep$vore)

glimpse(msleep)

# mutate allows to either create a new variable of
# overwriting an existing one
msleep %>% 
  mutate(vore = as.character(vore)) %>% 
  glimpse() 


# select variables to work with
names(msleep)

# 2:4 is looking for variables 2, 3 and 4 
# ("genus", "vore", "order")
#  the next variable is awake and any variable which starts with sth
# or contains sth 
msleep %>% 
  select(2:4, awake, starts_with("sleep"), contains("wt")) %>% 
  names()


# filter and arange data
unique(msleep$order)

# arrange is from smallest to biggest, 
# but with - it's going to do the opposite
msleep %>% 
  filter((order == "Carnivora" | order == "Primates") & 
           sleep_total > 8) %>% 
  select(name, order, sleep_total) %>% 
  arrange(-sleep_total) %>% 
  View()
  


msleep %>% 
  filter(order %in% c("Carnivora", "Primates") & 
           sleep_total > 8) %>% 
  select(name, order, sleep_total) %>% 
  arrange(order) %>% 
  View()


# Change observations (mutate)

msleep %>% 
  mutate(brainwt = brainwt * 1000) %>% 
  View()


msleep %>% 
  mutate(brainwt_in_grams = brainwt * 1000) %>% 
  View()


# if-else

msleep$brainwt
msleep$brainwt > 0.01


size_of_brain <- msleep %>% 
  select(name, brainwt) %>% 
  drop_na(brainwt) %>% 
  mutate(brain_size = if_else(brainwt > 0.01,
                              "large",
                              "small"))

size_of_brain


# recode data and rename a variable

size_of_brain %>% 
  mutate(brain_size = recode(brain_size, "large" = 1, "small" = 2))


# reshape the data from wide to long or long to wide
install.packages("gapminder")
library(gapminder)
View(gapminder)

data <- select(gapminder, country, year, lifeExp)

View(data)

# pivot_wider makes the years as columns and the lifeExp as values
wide_data <- data %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

# to bring the data as ti was from the beginning
long_data <- wide_data %>% 
  pivot_longer(2:13, 
               names_to = "year",
               values_to = "lifeExp")

View(long_data)


