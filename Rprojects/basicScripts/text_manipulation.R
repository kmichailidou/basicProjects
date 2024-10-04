library(tidyverse)
library(gtExtras)

view(iris)


f_name <- "John"
l_name <- "Earl"

str_c(f_name,l_name, sep = " ")


fnames <- c("John", "Keith")
lnames <- c("Earl", "Martin")

str_c(fnames,lnames, sep = " ")


names <- as.data.frame(str_c(fnames,lnames, sep = " "))


iris %>% 
  select(Species, Sepal.Length) %>% 
  mutate(Description = str_c(Species, ": ",
                             Sepal.Length, " cm")) %>% 
  gt() %>% 
  tab_header(title = "Iris data with Description") %>% 
  cols_align(align = "center") %>% 
  gt_theme_pff()






