library(tidyverse)



# Dropping unused levels
levels(gss_cat$race)

gss_cat %>% 
  select(race) %>% 
  table()


gss_cat %>% 
  mutate(race = fct_drop(race)) %>% 
  select(race) %>% 
  table()


# Modifying factor order
# using fct_relevel function 
gss_cat %>% 
  mutate(race = fct_drop(race)) %>% 
  mutate(race = fct_relevel(race,
                    c("White","Black","Other"))) %>% 
  select(race) %>% 
  table()


# Ordering factors and levels by the value of 
# the frequency count of that particular category
gss_cat %>% 
  mutate(marital = fct_infreq(marital)) %>% 
  mutate(marital = fct_rev(marital)) %>% 
  ggplot(aes(marital))+
  geom_bar(fill = "steelblue")


# Ordering the levels of one variable by 
# the average value or by the value in another variable 
gss_cat %>% 
  group_by(relig) %>% 
  summarise(meantv = mean(tvhours, na.rm = T)) %>% 
  mutate(relig = fct_reorder(relig, meantv)) %>% 
  ggplot(aes(meantv, relig))+
  geom_point(size = 4, color = "steelblue")



gss_cat %>% 
  mutate(partyid = fct_recode(
    partyid,
    "Republican, strong" = "Strong republican",
    "Republican, weak" = "Not str republican",
    "Independent, near rep" = "Ind, near rep",
    "Independent, near dem" = "Ind, near dem",
    "Democrat, weak" = "Not str democrat",
    "Democrat, strong" = "Strong democrat",
    "Other" = "No answer",
    "Other" = "Don't know",
    "Other" = "Other party")) %>% 
  count(partyid)
  

# the smart way
gss_cat %>% 
  mutate(partyid = fct_collapse(
    partyid,
    Other = c("No answer","Don't know","Other party"),
    Republican = c("Strong republican","Not str republican"),
    Independent = c("Ind, near rep","Independent","Ind, near dem"),
    Democrat = c("Not str democrat","Strong democrat"))) %>% 
  count(partyid)





