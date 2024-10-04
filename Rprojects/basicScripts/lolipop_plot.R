library(tidyverse)
library(forcats)



msleep %>% 
  group_by(order) %>% 
  summarise(mean_sleep = mean(sleep_total)) %>% 
  mutate(order = fct_reorder(order, mean_sleep)) %>% 
  ggplot(aes(x = order,
             y = mean_sleep))+
  labs(title = "Sleeptime of mammals",
       x = " ",
       y = "Hours")+
  theme(axis.text.x = 
          element_text(angle = 45,
                       vjust = 1,
                       hjust = 1),
        axis.text.y = element_text(face = "bold"),
        plot.title = element_text(hjust = 0.5,
                                  size = 25,
                                  face = "bold"))+
  theme(axis.text.x = element_text(color = "lightblue"),
        axis.text.y = element_text(color = "lightblue"),
        axis.title.y = element_text(color = "lightblue"),
        plot.title = element_text(color = "lightblue"),
        axis.line = element_text(color = "lightblue"),
        axis.ticks = element_text(color = "lightblue"),
        panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "none")+
  geom_hline(yintercept = mean(msleep$sleep_total),
             color = "lightblue",
             size = 1)+
  geom_segment(aes(x = order,
                   y = mean(msleep$sleep_total),
                   xend = order,
                   yend = mean_sleep),
               color = "lightblue")+
  geom_point(aes(color = mean_sleep),
             size = 5)+
  scale_color_gradient(low = "hotpink",
                       high = "yellow")+
  annotate("text",
           x = 4,
           y = max(msleep$sleep_total) - 4,
           label = "Average sleep\nfor all mammals",
           color = "#f4cccc",
           size = 4,
           fontface = "bold",
           hjust = 0)+
  geom_curve(aes(x = 3.7,
                 y = max(msleep$sleep_total) - 5,
                 xend = 1.5,
                 yend = mean(msleep$sleep_total)),
             color = "#f4cccc",
             curvature = 0.5,
             size = 0.5,
             arrow = arrow(length = unit(0.07, "npc"),
                           type = "open"))


