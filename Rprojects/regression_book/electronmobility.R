library(tidyverse)

dataset = read.csv("ElectronMobility.csv")


# Using linear model
lm_model <- lm(Mobility ~ Density.Ln, data = dataset)
summary(lm_model)

res1 <- resid(lm_model)

dataset %>% 
  ggplot(aes(Density.Ln, Mobility))+
  geom_point()+
  geom_smooth(method = lm, formula = y ~ poly(x,3), se= F)+
  theme_bw()+
  labs(title = "Fitted Line Plot",
       x = "Density.Ln",
       y = "Mobility")

res_plot1 <- plot(fitted(lm_model), res1)+
  abline(0,0)


# Using polynomial model
final_model <- lm(Mobility ~ Density.Ln + I(Density.Ln) + I(Density.Ln^2) + 
                    I(Density.Ln^3) / 1 + I(Density.Ln) + I(Density.Ln^2) + I(Density.Ln^3), data = dataset)
 

res2 <- resid(final_model)

dataset %>% 
  ggplot(aes(Density.Ln, Mobility))+
  geom_point()+
  geom_smooth(method = lm, formula =y ~ poly(x,7), se= F)+
  theme_bw()+
  labs(title = "Fitted Line Plot",
       x = "Density.Ln",
       y = "Mobility")


res_plot2 <- plot(fitted(final_model), res2)+
  abline(0,0)



rm(list = ls())
