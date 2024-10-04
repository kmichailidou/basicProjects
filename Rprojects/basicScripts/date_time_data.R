install.packages("nycflights13")
library(tidyverse)
library(lubridate)
library(nycflights13)
glimpse(flights)

# Create date-time objects
now() # output the date and time right now
ymd('2017-03-30')
mdy('March 30th, 2017')
dmy('30-Mar-2017')

ymd_hms('2017-03-30 20:11:59')
mdy_hm('03/30/2017 08:01')
""" 
make_date()
make_datetime()
make_difftime() -> create a duration object
today()
"""

flights %>% 
  select(origin, year, month,day, hour, minute) %>% 
  head(4)

flights %>% 
  mutate(flight_date = ymd_hm(paste(year, month, day, hour, minute))) %>% 
  select(origin, dest, flight_date) %>% 
  head(4)


flights %>% 
  mutate(flight_date = make_datetime(year, month,
                                     day, hour, minute)) %>% 
  select(origin, dest, flight_date) %>%
  head(4)


# Extract date-time objects
flights %>% 
  mutate(flight_date = make_date(year, month, day)) %>% 
  mutate(weekday = wday(flight_date, label = T),
         month_name = month(flight_date, label = T)) %>%
  select(origin, flight_date, weekday, month_name) %>% 
  head(4)
  

""" 
year()
month()
day()
hour()
minute()
second()
wday()
mday()
month()
"""
help("lubridate")

# Do arrhythmic with date-time objects
now() + years(30) # "2054-08-06 12:22:30 EEST" 

flights %>% 
  filter(time_hour >= ymd('2013-09-01')&
           time_hour < ymd('2013-10-01')) %>% 
  select(origin, month) %>% 
  head(4)



# Work with time spans (duration, periods and intervals)
my_duration <- dseconds(15) # "15s"
print(my_duration)
dminutes(1) # "60s (~1 minutes)"

# duration
ymd('2016-01-01') + dyears(1) # "2016-12-31 06:00:00 UTC"
# no duration
ymd('2016-01-01') + years(1) # "2017-01-01"

# period()
# seconds()

months(3) + days(1) + minutes(8) # "3m 1d 0H 8M 0S"
months(3) * 2 # "6m 0d 0H 0M 0S" 

# intervals 
start <- ymd_hms('2023-01-01 12:00:00')
end <- ymd_hms('2023-01-15 12:00:00')
iv <- interval(start,end)
print(iv) # 2023-01-01 12:00:00 UTC--2023-01-15 12:00:00 UTC

ymd_hms('2023-01-10 10:00:00') %within% iv # TRUE

start2 <- ymd_hms('2023-01-01 12:00:00')
end2 <- ymd_hms('2023-01-11 12:00:00')
iv2 <- interval(start2,end2)

iv>iv2 # TRUE 

# convert to duration or periods
as.duration(iv) # "1209600s (~2 weeks)"



# Visualizing date-time objects with ggplot2

flights %>% 
  filter(carrier %in% c('9E', 'US', 'AA', 'MQ')) %>% 
  mutate(week_day = wday(time_hour, label = T)) %>% 
  ggplot(aes(week_day))+
  geom_bar(fill = "steelblue", alpha= 0.8)+
  facet_wrap(~carrier)+
  theme_bw()+
  labs(title = 'Number of flights by carrier and weekday',
       x = 'Week days',
       y = "")+
  theme(plot.title = element_text(hjust = 0.5))


flights %>% 
  filter(time_hour < ymd('2013-10-01'),
    carrier %in% c('9E', 'US', 'AA', 'MQ')) %>% 
  ggplot(aes(time_hour, color = carrier))+
  geom_freqpoly(linewidth = 1.5)+
  theme_bw()+
  labs(title = 'Number of flights by carrier',
       x = "",
       y = "")+
  theme(plot.title = element_text(hjust = 0.5))


