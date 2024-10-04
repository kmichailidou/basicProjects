install.packages("sf")
install.packages("ggthemes")
install.packages("rnaturalearth")

library(tidyverse)
library(sf)
library(ggthemes)
library(rnaturalearth)


world <- ne_countries(scale = "medium",
                      returnclass = "sf")

view(world)


world %>% 
  ggplot(aes(fill = income_grp))+ 
  geom_sf()+
  labs(title = "World map
       by income group",
       fill = "Income group")+
  scale_fill_viridis_d()+
  theme_map()+
  theme(legend.position = "right",
        legend.title = element_text(face = "bold"),
        plot.title = element_text(size = 10,
                                  color = "steelblue",
                                  hjust = 0.5,
                                  face = "bold"))

world %>% 
  filter(region_un == "Africa") %>% 
  ggplot()+
  geom_sf(aes(fill = pop_est/1e6),
          # color of line
          color = "white",
          lwd = 0.3)+
  labs(title = "Africa by population size",
       fill = "Population \n(millions)")+
  theme_map()+
  theme(legend.position = "top",
        legend.key.width = unit(1.4, "cm"),
        plot.title = element_text(size = 9))




