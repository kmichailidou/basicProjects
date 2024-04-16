library(tidyverse)

glimpse(msleep)

# describe the spread, centrality and variance of your data
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)
mean(msleep$awake)
median(msleep$awake)
var(msleep$awake)


# summarise selected variables
summary(msleep)
summary(msleep$sleep_total)


msleep %>% 
  select(sleep_total, brainwt) %>% 
  summary()



msleep %>% 
  drop_na(vore) %>% 
  group_by(vore) %>% 
  summarise(Lower = min(sleep_total),
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            Difference = max(sleep_total) - min(sleep_total)) %>% 
  arrange(Average) %>% 
  View()



# creating contingency tables
install.packages("MASS")
library(MASS)
# not recommended 
attach(Cars93)

glimpse(Cars93)


table(Origin)
table(AirBags)
table(AirBags, Origin)
addmargins(table(AirBags, Origin), 1)


table(AirBags, Origin)
prop.table(table(AirBags, Origin), 2)*100
round(prop.table(table(AirBags, Origin), 2)*100)


Cars93 %>% 
  group_by(Origin, AirBags) %>% 
  summarise(number = n()) %>% 
  pivot_wider(names_from = Origin,
              values_from = number)


