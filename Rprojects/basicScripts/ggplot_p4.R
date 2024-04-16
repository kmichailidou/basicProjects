library(tidyverse)
names(msleep)
# two or more numeric variables

msleep %>% 
  filter(bodywt <2) %>% 
  ggplot(aes(bodywt, brainwt))+
  geom_point(aes(color = sleep_total,
                 size = awake))+
  geom_smooth()+
  labs(x="Body Weight",
       y="Brain Weight",
       title="Brain and body weight")+
  theme_minimal()



# geom_smooth(method = lm, se =F)
