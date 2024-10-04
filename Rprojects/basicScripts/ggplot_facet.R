library(tidyverse)
library(gapminder)



gapminder %>% 
  filter(gdpPercap < 40000 & 
           continent !="Oceania") %>% 
  ggplot(mapping = aes(x = gdpPercap,
                       y = lifeExp,
                       colour = continent))+
  geom_point(shape = "square",
             alpha = 0.5,
             size = 2)+
  labs(title = "Life expectancy as a function of wealth",
       x = "GDP per capita",
       y = "Life expectancy",
       colour = "Region")+
  theme_bw()


gapminder %>% 
  filter(gdpPercap < 40000 & 
           continent !="Oceania") %>% 
  ggplot(mapping = aes(x = gdpPercap,
                       y = lifeExp,
                       colour = year))+
  geom_jitter(shape = "square",
              alpha = 0.4,
              size = 2)+
  geom_smooth()+
  facet_wrap(~continent)+
  labs(title = "Life expectancy as a function of wealth",
       x = "GDP per capita",
       y = "Life expectancy",
       colour = "Region")+
  theme_bw()


library(forcats)

# facet wrap by partyid
gss_cat %>% 
  filter(partyid %in% c("Strong democrat",
                        "Strong republican",
                        "Independent")) %>% 
  ggplot(aes(age))+
  geom_histogram(binwidth = 5,
                 fill = "steelblue",
                 alpha = .8)+
  facet_wrap(~partyid,
             nrow = 1,
             ncol = 3,
             strip.position = "bottom")+
  labs(title = "Age distribution by political affiliation",
       x = "",
       y = "")+
  theme_bw()


# facet_grid
# facet wrap relig should be the row and the partyid is the columns
gss_cat %>% 
  mutate(relig = recode(relig,
                        "Moslem/islam" = "Muslim")) %>%
  filter(relig %in% c("Christian",
                      "Muslim") & 
           partyid %in% c("Strong democrat",
                          "Strong republican",
                          "Independent")&
           tvhours < 10) %>% 
  ggplot(aes(x = tvhours,
             color = partyid,
             fill = partyid))+
  geom_density(alpha = 0.3,
               show.legend = F)+
  facet_grid(relig ~ partyid)+
  labs(title = "TV watching by political and religious
       affiliation",
       x = "Hour spent watching TV",
       y = "")+
  theme_bw()
  



