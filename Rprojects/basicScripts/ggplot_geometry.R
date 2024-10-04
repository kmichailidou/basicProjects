library(tidyverse)

# Scatter plot
mtcars %>% 
  ggplot(aes(x = wt, y= mpg))+
  geom_point(size = 3,
             colour = "steelblue",
             alpha = 0.6)+
  labs(title = "Weight vs Miles per Gallon",
       x = "Weight",
       y = "Miles Per Gallon")+
  theme_bw()


# Line Graph
Orange %>% 
  ggplot(aes(x = age,
             y = circumference,
             color = Tree))+
  geom_line()+
  labs(title = "Circumference as a functions of age",
       x = "Age",
       y = "Circumference")+
  theme_bw()


# Bar chart
mpg %>% 
  ggplot(mapping = aes(x = class))+
  geom_bar(fill="steelblue",
           alpha = 0.8)+
  labs(title = "Number of cars in each class",
       x = "",
       y = "")+
  theme_bw()


# Histogram
mpg %>% 
  ggplot(aes(x =cty))+
  geom_histogram(binwidth = 2,
                 fill= "steelblue",
                 alpha = 0.8)+
  labs(title = "Fuel efficiency of cars in the city",
       x = "Miles per Gallon",
       y = "Number of cars")+
  theme_bw()



# Density Plot

mpg %>% 
  ggplot(aes(x = cty))+
  geom_density(fill = "steelblue",
               alpha = 0.8)+
  labs(title = "Fuel efficiency of cars in the city",
       x = "Miles per Gallon",
       y = "")+
  theme_bw()


mpg %>% 
  filter(drv %in% c("f", "r")) %>% 
  ggplot(aes(x = cty,
             fill = drv,
             color = drv))+
  geom_density(alpha = 0.3)+
  labs(title = "Fuel efficiency of cars in the city",
       x = "Miles per Gallon",
       y = "")+
  theme_bw()


# Box Plot
mpg %>% 
  filter(cty < 25) %>% 
  ggplot(aes(x = cty,
             fill = drv))+
  geom_boxplot(alpha = 0.5)+
  labs(title = "Fuel efficiency of cars in the city",
       x = "Miles per Gallon",
       y = "Drive")+
  theme_bw()


# Area plots
# Error 
ggplot(mpg, aes(x = displ))+
  geom_area(aes(y = hwy, fill = "Highway"))+
  geom_area(aes(x = cty, fill = "City"))+
  labs(title = "Highway vs City driving",
       x = "Engine Displacement (L)",
       y = "Miles per Gallon",
       fill = "")+
  theme_bw()


# Raster slots

faithfuld %>% 
  ggplot(aes(x = waiting,
             y = eruptions,
             fill = density))+
  geom_raster()+
  labs(title = "Old faithful Geyser",
       x = "Waiting time between erruptions",
       y = "Duration of eruptions",
       fill = "Density")+
  theme_bw()





