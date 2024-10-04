install.packages("pander")
library(tidyverse)
library(pander)


trees %>% 
  ggplot(aes(Girth, Volume, color=Height))+
  geom_point()+
  geom_smooth(method = lm, se = F)+
  theme_bw()+
  labs(title = "Tree volume explained by Girth and Height")

# all of lm should be created as objects
lm1 <- lm(Volume ~ Girth + Height, data = trees) %>% 
  summary()

lm1

# with categorical variables (two categories)
mpg %>% 
  ggplot(aes(x=displ,
             y=hwy))+
  geom_jitter()+
  geom_smooth(method = lm, se = F)+
  theme_bw()+
  labs(title = "Highway fuel efficiency explained by engine size",
       x = "Engine size",
       y = "Highway fuel efficiency")

lm2 <- lm(hwy ~ displ, data = mpg) %>% 
  summary()

lm2

mpg %>% 
  mutate(drv= fct_recode(drv, "2" = "f", "2" = "r")) %>% 
  ggplot(aes(displ, hwy, color = drv))+
  geom_point()+
  geom_smooth(method = lm, se = F)+
  theme_bw()+
  labs(title = "Highway fuel efficiency explained by engine size",
       x = "Engine size",
       y = "Highway fuel efficiency",
       color = "Drive")


# choosing some categories
mpg %>% 
  mutate(drv= fct_recode(drv, "2" = "f", "2" = "r")) %>% 
  lm(hwy ~ displ + drv, data = .) %>% 
  summary()


install.packages("palmerpenguins")
library(palmerpenguins)


penguins %>% 
  ggplot(aes(bill_depth_mm, bill_length_mm))+
  geom_point()+
  geom_smooth(method = lm, se = F)+
  theme_bw()+
  labs(title = "Penguin bill length explained by bill depth",
       x = "Bill depth",
       y = "bill length")

# the same but different
penguins %>% 
  ggplot(aes(bill_depth_mm, bill_length_mm))+
  geom_point(aes(color = species), alpha=0.7)+
  geom_smooth(aes(color = species), method = lm, se = F)+
  theme_bw()+
  labs(title = "Penguin bill length explained by bill depth",
       x = "Bill depth",
       y = "bill length")


lm3 <- lm(bill_length_mm ~ bill_depth_mm + species, data = penguins) %>% 
  summary()

lm3





