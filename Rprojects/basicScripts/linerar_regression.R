install.packages("lmtest")
library(lmtest)

# with only x and y, independent and dependent
lm(formula = weight ~ height, data = women) %>% 
  summary()

# with two variables at the dependent side
# numeric variable as additional explanatory 
lm(formula = Volume ~ Girth + Height, data = trees) %>% 
  summary()

# including categorical variable (2 categories)
lm(formula = hwy ~ displ + drv, data = .) %>% 
  summary()# error

# interactions
lm(formula = mpg ~ wt, data = mtcars) %>% 
  summary()

#transmission 
lm(formula = mpg ~ wt * am, data = .) %>% 
  summary()#error 





