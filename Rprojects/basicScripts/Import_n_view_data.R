my_data <- read.csv("1.supermarket.csv") 

#View data
head(my_data)
tail(my_data)
View(my_data)
# each row is an observation and each column is a variable

# Extract components of your dataframe
my_data[1,3] # rows and columns -> "Chips" 
my_data[ ,3] # gives the entire column 
my_data$item_name #does the same thing as the previous command

# Install and use packages
# When you install a package, you do it once 
# Also you have to use library() or require() to mention the package
install.packages("tidyverse")
library("tidyverse")


# Analyzing the data 
# for the symbol press shift+ctrl+m
my_data %>% 
  select(order_id,item_name,item_price) %>% 
  filter(item_price < 3.0 & item_name =='Milk') %>% 
  arrange(item_price)


