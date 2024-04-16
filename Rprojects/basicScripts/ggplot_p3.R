library(tidyverse)
?msleep
View(msleep)

# single categorical

names(msleep)
msleep %>% 
  drop_na(vore) %>% 
  ggplot(aes(x = vore))+
  geom_bar(fill = "#97B3C6")+
  #coord_flip()+ -> flips the plot
  theme_bw()+
  labs(x = "Vore",
       y = NULL,
       title = "Number of observations per order")

# use fct_infreq(vore)to create order (inside of aes())

# single numeric

msleep %>% 
  ggplot(aes(awake))+
  geom_histogram(binwidth = 2, fill = "#97B3C6")+
  theme_bw()+
  labs(x = "Total sleep",
       y = NULL,
       title = "Histogram of total sleep") 



