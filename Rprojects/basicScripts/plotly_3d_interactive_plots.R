install.packages("plotly")
library(tidyverse)
library(plotly)


p <- starwars %>% 
  drop_na(height, mass, eye_color) %>% 
  filter(mass < 250) %>% 
  filter(eye_color %in% c("blue",
                          "brown",
                          "black",
                          "pink",
                          "red",
                          "orange")) %>% 
  ggplot(aes(x=height,
             y=mass,
             color = eye_color))+
  geom_jitter(size = 6,
              alpha = .5)+
  scale_color_manual(values = c("blue" = "blue",
                                "brown" = "brown",
                                "black" = "black",
                                "red" = "red",
                                "orange" = "orange"))+
  theme_bw()+
  theme(legend.position = c(0.05,0.98),
        legend.justification = c("left","top"))+
  labs(title = "Height, mass and eye color",
       x = "Height",
       y = "Mass",
       color = "Eye Color")


p

ggplotly(p) 



# 3d scatter plots
trees %>% 
  plot_ly(x = ~Girth,
          y = ~Height,
          z = ~Volume) 

# Surface 
plot_ly(z = volcano, type = "surface")

