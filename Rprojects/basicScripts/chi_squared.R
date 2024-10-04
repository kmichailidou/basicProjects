library(tidyverse)
library(patchwork)

head(iris)

# cut is for cutting some data from the data set
flowers <- iris %>% 
  mutate(Size = cut(Sepal.Length,
         breaks = 3,
         labels = c("Small", "Medium","Large"))) %>% 
  select(Species, Size)

table(flowers)


# chi squared test of fit test
# Question: Is there a statistically significant difference 
# in small proportion of flowers that are small, medium
# and large (alpha = 0.5) 

# chi squared goodness of fit test 

# H0: The proportion of flowers that are small, 
# medium sized and large are equal 

# H1: The proportion of flowers that are small, 
# medium sized and large are not equal 


table(flowers$Size)

flowers %>% 
  select(Size) %>% 
  table() %>% 
  chisq.test()


# the p value is extremely small
# so, if the proportion were equal, the probability of sample data
# providing a difference of this magnitude or 
# more is < 0.05 therefor

# Reject the H0 (that the proportions are equal)
# Evidence that the proportions are not equal 


# Chi square test of independence 

# H0: The variables are independent
# There is no relationship between the variables

# Knowing the value of one variable does not help to 
# predict the value of the other variable


# H1 : The variables are dependent
# There is a relationship between the variables

# Knowing the value of one variable does help to 
# predict the value of the other variable


chisq.test(table(flowers))

table(flowers) %>% 
  chisq.test()


flowers %>% 
  table() %>% 
  chisq.test()


# fishers exact test if > 20% of expected values are < 5
# or all are if any values of < 5 in a 2x2

flowers %>% 
  table() %>% 
  chisq.test() %>% 
  .$expected 


my_test <- flowers %>% 
  table() %>% 
  chisq.test()

attributes(my_test)

# same with .$expected
my_test$expected
