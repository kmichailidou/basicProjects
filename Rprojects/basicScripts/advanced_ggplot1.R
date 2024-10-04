install.packages("car")
library(car)
library(tidyverse)


theme_set(theme_bw())

# Quick look at the data
head(Salaries)

# Plot salary vs yrs since PhD
Salaries %>% 
  ggplot(aes(x = yrs.since.phd,
         y = salary,
         color = rank))+
  geom_point()



Salaries %>% 
  ggplot(aes(x = yrs.since.phd,
             y = salary,))+
  geom_jitter(aes(color = rank, shape = discipline))+
  geom_smooth(method = lm)+
  facet_wrap(~sex)+
  labs(title = "Salary vs years since PhD",
       x = "Years since PhD",
       y = "Income",
       color = "Postion",
       shape = "Research area")



#geom_jitter is for our plot to not draw a second line
#in it and ruin the plot, 
#and that applies only to that specific line of code

 

# learn how to change tic marks and tic marks labels
Salaries %>% 
  filter(salary < 150000) %>% 
  ggplot(aes(x=rank, y=salary, fill = sex))+
  geom_boxplot(alpha=0.5)+
  labs(title = "Faculty Salary by Rank and Gender",
       x="",
       y="",
       fill="Gender")


# cange of tics and tic labels
Salaries %>% 
  filter(salary < 150000) %>% 
  ggplot(aes(x=rank, y=salary, fill = sex))+
  geom_boxplot(alpha=0.5)+
  scale_x_discrete(breaks=c("AsstProf",
                            "AsoocProf",
                            "Prof"),
                   labels=c("Assisstant\nProfessor",
                            "Associate\nProfessor",
                            "Full\nProfessor"))+
  scale_y_continuous(breaks=c(50000, 
                              100000,
                              150000,
                              200000),
                     labels=c("$50K",
                              "$100K",
                              "$150K",
                              "$200K"))+
  labs(title="Faculty Salary by Rank and Gender",
       x="",
       y="",fill="Gender")+
  theme(legend.position = c(.11,.78))






