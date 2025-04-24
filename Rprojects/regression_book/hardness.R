# install.packages("effects") 
# library(tidyverse)
library(ggplot2)
library(gridExtra)

dataset = read.csv('hardness.csv')

model = lm(formula = Hardness ~ Pressure * Temp, data = dataset)

#mean_temp = mean(dataset$Temp)

#pressure_seq <- seq(min(dataset$Pressure), max(dataset$Pressure), length.out = 100)

#predicted_hardness <- predict(model, newdata = data.frame(Pressure = pressure_seq, Temp = mean_temp))

#plot(pressure_seq, predicted_hardness, type = "l", col = "blue",
 #    xlab = "Pressure", ylab = "Predicted Hardness",
  #   main = "Main Effects Plot (Temp fixed at Mean)")
#grid()


plot1 <- ggplot(dataset,aes(Pressure, Hardness))+
  geom_smooth(method = lm,formula = y ~ poly(x,2), se = F)+
  theme_bw()+
  labs(title = "Main Effects Plot for Hardness")

plot2 <- ggplot(dataset,aes(Temp, Hardness))+
  geom_point()+
  geom_smooth(method = lm, formula = y ~ x, se = F)+
  theme_bw()+
  labs(title = "Main Effects Plot for Hardness")


grid.arrange(plot1, plot2, ncol = 2)  


rm(list = ls())
