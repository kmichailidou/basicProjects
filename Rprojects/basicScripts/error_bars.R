library(tidyverse)

# View(ToothGrowth)
?ToothGrowth

# if you apply the theme from the beginning (like this case)
# the the theme will be applied to all of the plots will be 
# created in the future
theme_set(theme_bw()+
            theme(panel.grid.major = element_blank()))

view(ToothGrowth)
?sd # -> standard deviation

ToothGrowth %>% 
  filter(supp == "VC") %>% 
  mutate(dose = as.factor(dose)) %>% 
  group_by(dose) %>% 
  summarise(mean_len = mean(len),
             sd_len = sd(len)) %>% 
  ggplot(aes(dose, mean_len))+
  geom_point(size = 3, colour = "blue")+
  geom_errorbar(aes(x = dose, 
                    ymin = mean_len - sd_len,
                    ymax = mean_len + sd_len,
                    width = 0.05))+
  labs(title = "Average tooth growth for VC")+
  xlab("Dose")+
  ylab("Average tooth growth")

  
?geom_errorbar
  
  
  
  
  


