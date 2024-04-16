my_data <- msleep %>% 
  select(name, sleep_total) %>% 
  filter(!sleep_total > 18)

# the comma here is the same as and  
my_data <- msleep %>% 
  select(name, order, bodywt, sleep_total) %>% 
  filter(order == "Primates", bodywt > 20)


my_data <- msleep %>% 
  select(name, order, bodywt, sleep_total) %>% 
  filter(order == "Primates" | bodywt > 20)


my_data <- msleep %>% 
  select(name, sleep_total) %>% 
  filter(name == "Cow" | name == "Dog" | name == "Goat")


my_data <- msleep %>% 
  select(name, sleep_total) %>% 
  filter(name %in% c( "Cow","Dog","Horse"))


my_data <- msleep %>% 
  select(name, sleep_total) %>% 
  filter(between(sleep_total, 16, 18))

# close to 17 with a .5 parameter
my_data <- msleep %>% 
  select(name, sleep_total) %>% 
  filter(near(sleep_total, 17, tol = 0.5))


my_data <- msleep %>% 
  select(name, conservation, sleep_total) %>% 
  filter(is.na(conservation))

# and the opposite is with the ! operator in front of is.na() 


