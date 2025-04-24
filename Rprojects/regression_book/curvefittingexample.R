library(tidyverse)
library(ggplot2)
library(dplyr)

dataset = read.csv('CurveFittingExample.csv')
dataset$Reciprocal_Input <- 1 / dataset$Input * dataset$InvInput

cmodel <- lm(formula = Output ~ Input + I(Input^2), data = dataset)
summary(cmodel)


dataset %>% 
  ggplot(aes(Input, Output))+
  geom_point()+
  geom_smooth(method = lm, formula = y ~ poly(x,2), se = F)+
  theme_bw()+
  labs(title = "Fitted line plot",
       x = "Input",
       y = "Output")


?geom_smooth

rm(list = ls())

#If you don't want to specify a polynomial degree but instead 
#prefer a locally smoothed curve, you can use method = "loess". 
#This method is non-parametric and fits a smooth curve to the data
# geom_smooth(method = "loess", se = FALSE)

# Alternatively, you can use a more flexible model like a 
#Generalized Additive Model (GAM) using the method = "gam" argument, 
#which automatically fits a non-linear model.
# geom_smooth(method = "gam", se = FALSE)


