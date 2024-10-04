library(tidyverse)
library(forcats)

theme_set(theme_bw()+
            theme(panel.grid = element_blank()))

?geom_segment


msleep %>% 
  group_by(order) %>% 
  summarise(mean_sleep = mean(sleep_total)) %>% 
  mutate(order = fct_reorder(order, mean_sleep)) %>% 
  ggplot(aes(x = order, y = mean_sleep))+
  geom_point(size = 3,
             colour = "orange")+
  geom_segment(aes(x = order,
                   y = mean(msleep$sleep_total),
                   xend = order,
                   yend = mean_sleep),
               colour = "grey")+
  geom_hline(yintercept = mean(msleep$sleep_total),
             colour = "grey",
             size = 1)+
  theme(axis.text.x = element_text(angle = 90))+
  labs(title = "Average sleep tiem of mammals by order",
       x = "",
       y = "Hours")


