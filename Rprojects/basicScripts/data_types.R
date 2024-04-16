
my_data <- read.csv("book_reviews.csv") 
# str() is for structure of a dataset
str(my_data)
# changing the data type for a variable e.g. from chr to factor
my_data$state <- as.factor(my_data$state)
# num to int
my_data$price <- as.integer(my_data$price)
# levels of data
levels(my_data$review)
my_data$review <- factor(my_data$review,
                         levels = c("Excellent","Great","Fair","Poor"),
                         )

# logicals
my_data$five <- my_data$price > 5
class(my_data$five)
str(my_data)

