# install.packages("tidyverse")
require(tidyverse)
# View the existing datasets with data()
data()
# View and load the dataset
View(starwars) 
starwars %>% 
  select(gender, mass, height, species) %>% 
  filter(species == "Human") %>% 
  na.omit() %>% # removes the NA
  mutate(height = height/100) %>% 
  mutate(BMI = mass / height^2) %>% 
  group_by(gender) %>% 
  summarise(Average_BMI = mean(BMI))
