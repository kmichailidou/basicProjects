library(tidyverse)
library(forcats)
library(patchwork)


?forcats
View(gss_cat)

# order of categorical variables matters 

#p1
#p2
#p3


unique(gss_cat$race)

# pull is going to pull the race variable out as a vector
gss_cat %>% 
  pull(race) %>% 
  unique()


count(gss_cat, race, sort = T)

gss_cat %>% 
  count(race)


gss_cat %>% 
  pull(race) %>% 
  levels()


gss_cat %>% 
  select(race) %>% 
  table()



# forcats functions

?mutate

gss_cat %>% 
  mutate(race = fct_drop(race)) %>% 
  pull(race) %>% 
  levels()


# order a factor by the value
# of another numeric variable
# (order by mean_tv)

gss_cat %>% 
  drop_na(tvhours) %>% 
  group_by(relig) %>% 
  summarise(mean_tv = mean(tvhours)) %>% 
  ggplot(aes(mean_tv, relig))+
  geom_point(size = 4)


# reordering the relig by mean_tv 

gss_cat %>% 
  drop_na(tvhours) %>% 
  group_by(relig) %>% 
  summarise(mean_tv = mean(tvhours)) %>%
  mutate(relig = fct_reorder(relig,mean_tv)) %>% 
  ggplot(aes(mean_tv, relig))+
  geom_point(size = 4)

  
  
gss_cat %>% 
  drop_na(age) %>% 
  filter(rincome != "Not applicable") %>% 
  group_by(rincome) %>% 
  summarise(mean_age = mean(age)) %>% 
  ggplot(aes(mean_age,rincome))+
  geom_point(size = 4)
  


gss_cat %>% 
  drop_na(age) %>% 
  filter(rincome != "Not applicable") %>% 
  group_by(rincome) %>% 
  summarise(mean_age = mean(age)) %>% 
  mutate(rincome = fct_rev(rincome)) %>% 
  ggplot(aes(mean_age,rincome))+
  geom_point(size = 4)



# order levels by frequency of
# the value of that variable 

gss_cat %>% 
  count(marital)

gss_cat %>% 
  ggplot(aes(marital))+
  geom_bar()

gss_cat %>% 
  mutate(marital = fct_infreq(marital)) %>% 
  count(marital)


gss_cat %>% 
  mutate(marital = fct_infreq(marital)) %>% 
  mutate(marital = fct_rev(marital)) %>% 
  count(marital)


gss_cat %>% 
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>% 
  ggplot(aes(marital))+
  geom_bar(fill="steelblue", alpha = 0.5)+
  theme_bw()

  
  
# recode factors
gss_cat %>% 
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong" = "Strong",
                              "Republican, weak" = "Weak",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak" = "Not str Democrat",
                              "Democrat, strong" = "Strong democrat",
                              "Other" = "Not answer",
                              "Other" = "Don't know",
                              "Other" = "Other party")) %>% 
  count(partyid)



gss_cat %>% 
  mutate(partyid = fct_collapse(partyid,
                                other = c("No answer"),
                                rep = c("Strong Republican"),
                                ind = c("Ind, near Republican"),
                                dem = c("Not str democrat"))) %>% 
  count(partyid)


# lumping into "other"

gss_cat %>% 
  count(relig, sort = T)


gss_cat %>% 
  mutate(relig = fct_lump(relig, n=2)) %>% 
  count(relig)


# reordering a factor by it's value corresponding
# the largest x value

gss_cat %>% 
  filter(!is.na(age)) %>% 
  filter(marital %in% c("Never Married",
                        "Married",
                        "Widowed")) %>% 
  count(age,marital) %>% 
  group_by(age) %>% 
  mutate(prop = n / sum(n)) %>% 
  ggplot(aes(age, prop, colour = marital))+
  geom_line(size = 2, na.rm = TRUE)+
  theme_minimal()



gss_cat %>% 
  filter(!is.na(age)) %>% 
  filter(marital %in% c("Never Married",
                        "Married",
                        "Widowed")) %>% 
  count(age,marital) %>% 
  group_by(age) %>% 
  mutate(prop = n / sum(n)) %>% 
  mutate(marital = fct_reorder2(marital, age, prop)) %>% 
  mutate(marital = fct_rev(marital)) %>% 
  ggplot(aes(age, prop, colour = marital))+
  geom_line(size = 2, na.rm = TRUE)+
  theme_minimal()


