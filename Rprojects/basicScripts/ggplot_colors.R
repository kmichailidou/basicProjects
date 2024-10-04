install.packages("RColorBrewer")
library(tidyverse)
library(RColorBrewer)


display.brewer.all(colorblindFriendly = TRUE)


# we set scale_color_brewer because color = drv
# if this was fill for some plots (e.g. barplot)
# it should be fill_color_brewer because we fill the bar
mpg %>% 
  ggplot(aes(displ, hwy, color = drv))+
  geom_jitter(size = 5)+
  scale_color_brewer(palette = "Set2")+
  theme_minimal()


mpg %>% 
  ggplot(aes(displ, hwy))+
  geom_jitter(color = "steelblue",
              size = 5)+
  theme_minimal()



# mapping color against
mpg %>%  
  ggplot(aes(displ, hwy, color = drv))+
  geom_jitter(size = 5)+
  scale_color_manual(values = c("4" = "darkblue",
                                "f" = "darkred",
                                "r" = "darkgreen"))+
  theme_minimal()



# and with hex code
mpg %>% 
  ggplot(aes(displ, hwy, color = drv))+
  geom_jitter(size = 5)+
  scale_color_manual(values = c("4" = "#719AC9",
                                "f" = "#75B99C",
                                "r" = "#C98D71"))+
  theme_minimal()



