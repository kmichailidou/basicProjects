library(tidyverse)

#simple regression 
# creating a linear model
#interpreting the results
# predictive modeling (*) 


head(women)

women %>% 
  ggplot(aes(height, weight))+
  geom_point(size = 3, alpha = .5)+
  geom_smooth(method = lm, se = F)+
  theme_bw()+
  labs(title = "Weight explained by Height in Women",
       x = "Height(explanatory or independent variable)",
       y = "Weight (outcome or dependent varible)")

# create and generate a summary of the model
model1 <- lm(weight ~ height, data = women)
summary(model1)


# (*)
# create a new obj that is a data frame 
# containing new values
new_data <- data.frame(height = 68)

# use the predict() function to generate new outcome values
predict(model1, new_data)


# also it can be with multiple points
new_data <- data.frame(height = c(68, 70, 72))
round(predict(model1, new_data))



#multiple regression
# adding categorical variables
# adding numeric numbers
# selecting variables

#diagnostics
# linearity
# the residuals 
#   normally distributed
#   homoscedastic
#   independence 

#special considerations
# outliers
# colinear variables 
# confounding variables
# effect modifiers / variable interaction


