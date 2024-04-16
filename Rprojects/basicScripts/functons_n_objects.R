plot(cars)
hist(cars$speed)

# attach is a function that attach a parameter 
attach(cats)
hist(dist)

# summary gives the min, median, mean and max 
summary(cars)
summary(cars$speed)

# class gives the class of an object
class(cars) # dataframe
class(cars$speed) # numeric 
length(cars$speed) # gives the rows of a column

# unique values in that variable 
unique(cars$speed)
head(cars)
tail(cars)

# create a new subdataframe with the values from the main dataset
subset <- cars[3:6,1:2]

# help
?median
median(cars$dist)
new_data <- c(2,4,6,3,NA,9)
median(new_data, na.rm = TRUE)
