install.packages("gganimate")
install.packages("babynames")
install.packages("viridis")

library(tidyverse)
library(gganimate)
library(babynames)
library(gapminder)
library(viridis)
library(RColorBrewer)

# Keep only 3 names
babynames %>% 
  filter(name %in% c("James","Paul","Andrew","John")) %>% 
  filter(sex == "M") %>% 
  ggplot(aes(x=year,
             y=n,
             group = name,
             color=name))+
  geom_line(linewidth = 1.5)+
  theme_bw()+
  scale_color_viridis(discrete = TRUE)+
  labs(title = "Popularity of American names in the previous",
       x = "",
       y = "",
       color = "Names")+
  theme(plot.title = element_text(size = 10,
                                  color = "steelblue"))+
  transition_reveal(year)



ggplot(gapminder,
       aes(x = gdpPercap,
           y = lifeExp,
           size = pop,
           color = continent))+
  geom_point()+
  scale_x_log10()+
  theme_bw()+
  labs(title = "Year: {frame_time}",
       x = "GDP per capita",
       y = "Life expectancy")+
  theme(plot.title = element_text(size = 50,
                                  hjust = 0.5,
                                  color = "steelblue"))+
  transition_time(year)


# save the gif
anim_save("271-ggplot-animated-gif-chart-with-gganimate.gif")

?anim_save

gapminder %>% 
  filter(continent !="Oceania") %>% 
  ggplot(aes(x = gdpPercap,
             y = lifeExp,
             size = pop,
             colour = country))+
  geom_point(alpha = 0.7,
             show.legend =  FALSE)+
  scale_color_manual(values = country_colors)+
  scale_size(range = c(2, 12))+
  scale_x_log10()+
  facet_wrap(~continent)+
  theme_bw()+
  labs(title = "Year: {frame_time}",
       x = "GDP per capita",
       y = "Life expectancy")+
  theme(plot.title = element_text(size = 50,
                                  hjust = 0.5,
                                  color = "steelblue"))+
  transition_time(year)

# barplot
ggplot(ChickWeight, aes(x = factor(Diet),
                        y = weight,
                        fill = Diet))+
  geom_bar(stat = "identity")+
  theme_bw()+
  scale_fill_brewer(palette = "Set2")+
  labs(title = "Time: {frame_time}",
       x = "Diet",
       y = "Weight")+
  theme(plot.title = element_text(size = 20,
                                  color = "steelblue"))+
  transition_time(Time)





