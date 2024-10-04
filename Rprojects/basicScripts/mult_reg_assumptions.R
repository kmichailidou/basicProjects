library(tidyverse)
library(lmtest)

# four basic assumptions

# linear relationship between exposure variable
# and the outcome variable

# residuals follow a normal distribution 
# residuals are homoscedastic
# residuals are independent 


mtcars %>% 
  mutate(predicted = predict(lm(mpg ~ wt, data = .))) %>% 
  ggplot(aes(wt, mpg))+
  geom_point(size = 1.5)+
  geom_smooth(method = lm, se = F, size = 0.5)+
  geom_segment(aes(xend = wt, yend = predicted), 
               color = "red")+
  theme_bw()


modell <- lm(mpg ~ wt, data = mtcars)
plot(modell)


# assumptions 

mtcars %>% 
  mutate(fitted = fitted(model)) %>% 
  mutate(residuals = residuals(model)) %>% 
  ggplot(aes(fitted, residuals))+
  geom_point()+
  geom_hline(yintercept = 0, color = "red",
             linetype = "dashed")+
  theme_bw()+
  labs(title = "Residuals vs Fitted values",
       x = "Fitted values",
       y = "residuals")


# lm test
harvtest(model)
# data:  model
# HC = 0.23045, df = 29, p-value = 0.8194

shapiro.test(residuals(model))
# data:  residuals(model)
# W = 0.94508, p-value = 0.1044


