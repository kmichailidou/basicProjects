install.packages("naniar")
library(tidyverse)
library(naniar)
library(gtExtras)


view(airquality)
view(starwars)

# naniar function
miss_var_summary(airquality) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Missigness of variables")

# plot
gg_miss_var(airquality)

# table of observations with missing data
# !complete.cases(.) -> shows that something is missing
airquality %>% 
  filter(!complete.cases(.)) %>% 
  head(10) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "MRows that contain missing values")

# the relationship to one variable
airquality %>% 
  mutate(Missing_Ozone = factor(is.na(Ozone),
                                levels = c("TRUE","FALSE"),
                                labels = c("Missing","Not missing"))) %>% 
  ggplot(aes(x = Wind, fill = Missing_Ozone))+
  geom_histogram(position = "stack")+
  labs(title = "Distribution of Wind Speeds for Missing Ozone",
       x = "Wind speed",
       y = "Ozone Observations",
       fill = "Missingness")+
  theme_bw()

# swapping levels
airquality %>% 
  mutate(Missing_Ozone = factor(is.na(Ozone),
                                levels = c("FALSE","TRUE"),
                                labels = c("Missing","Not missing"))) %>% 
  ggplot(aes(x = Wind, fill = Missing_Ozone))+
  geom_histogram(position = "stack")+
  labs(title = "Distribution of Wind Speeds for Missing Ozone",
       x = "Wind speed",
       y = "Ozone Observations",
       fill = "Missingness")+
  theme_bw()


airquality %>% 
  select(Ozone, Solar.R, Wind, Temp) %>% 
  ggplot(aes(x = Wind,
             y = Temp,
             size = Solar.R,
             color = is.na(Ozone)))+
  geom_point(alpha = 0.7)+
  facet_wrap(~is.na(Ozone))+
  labs(title = "Missing Ozone data by wind and temperature",
       color = "Missing Ozone Data",
       y = "Temperature",
       x = "Wind Speed")+
  theme_bw()

# dealing with missing values
# drop missing values

starwars %>% 
  select(name, mass, height, hair_color) %>% 
  head(15) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Starwars characters") %>% 
  gt_highlight_rows(rows = is.na(mass),
                    fill = "steelblue") %>% 
  gt_highlight_rows(rows = is.na(hair_color),
                    fill = "lightpink")



starwars %>% 
  select(name, mass, height, hair_color) %>% 
  drop_na(mass) %>% 
  head(20) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Starwars characters")


# change missing values
starwars %>% 
  select(name, hair_color, species) %>% 
  head(5) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Starwars characters")


starwars %>% 
  select(name, hair_color, species) %>% 
  filter(species == "Droid") %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Starwars characters")

# ~ -> means then in this example
starwars %>% 
  select(name, hair_color, species) %>% 
  filter(species == "Droid") %>% 
  mutate(hair_color = case_when(
    is.na(hair_color)&
      species == "Droid" ~ "none",
    TRUE ~ hair_color)) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Starwars characters")


# imputation 
starwars %>% 
  select(name, height) %>%
  filter(is.na(height)) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Starwars characters")

# TRUE ~ height -> this is just like else condition 
starwars %>% 
  mutate(height = case_when(
    is.na(height) ~ median(starwars$height,
                           na.rm = TRUE),
    TRUE ~ height)) %>% 
  select(name, height) %>% 
  arrange(name) %>% 
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Starwars characters") %>% 
  gt_highlight_rows(rows = name %in% c("Arvel Crynyd",
                                       "Poe Dameron",
                                       "BB8",
                                       "Captain Phasma"),
                    fill = "steelblue")
