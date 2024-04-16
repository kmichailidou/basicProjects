library(tidyverse)

View(starwars)
#glimpse is summary of the data set
glimpse(starwars)
class(starwars$gender)
unique(starwars$gender)

# turning into categorical
starwars$gender <- as.factor(starwars$gender)
class(starwars$gender)

# this is about the order they are presented in console
levels(starwars$gender)

# changing the order
starwars$gender <- factor((starwars$gender),
                          levels = c("masculine",
                                     "feminine"))
levels(starwars$gender)


# select variables
names(starwars)


starwars %>% 
  select(name, height, ends_with("color")) %>% 
  names()

# ends_with("color") -> 
# "name"       "height"     "hair_color" "skin_color" "eye_color"



# Filter observations
unique(starwars$hair_color)

starwars %>% 
  select(name, height, ends_with("color")) %>% 
  filter(hair_color %in% c("blond", "brown") &
           height < 180)
  
# Missing data

# because there's always possible to have NA data, 
# na.rm = TRUE allows the command to be executed
mean(starwars$height, na.rm = TRUE)

starwars %>% 
  select(name, gender, hair_color, height)

# not recommended because we can't know exactly what data we erase
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  na.omit()

# . refers to the whole dataset 
starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.))


starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  drop_na(height)


starwars %>% 
  select(name, gender, hair_color, height) %>% 
  filter(!complete.cases(.)) %>% 
  mutate(hair_color = replace_na(hair_color, "none"))



# Duplicates

Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)

friends <- data.frame(Names, Age)

friends[!duplicated(friends), ]

# distinct is the sane thing with the previous line 
friends %>% distinct()


# Recoding Variables
starwars %>% 
  select(name, gender) %>% 
  mutate(gender = recode(gender,
                         "masculine" = 1,
                         "feminine" = 2))


