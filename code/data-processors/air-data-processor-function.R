### Author: Fatemeh Kazemi - 01-01-2021

library(tidyverse)
library(lubridate)

# Air_Daily_Process function
### Function *** Air_Daily_Process ***
### Processes Daily data 
### Chooses a subset of monitors on the basis of: 
### ... A minimum for number of :
### ... Daily measurements per Month,
### ... Months with minimum daily measurements per Year
### ... Years with minimum Month and Day

# Function Arguments: 
# d : minimum number of days per month
# m : minimum numbers of month per year
# y : minimum numbers of years per period
# Packages: tidyverse; data.table

Air.Daily.Process <- function(dt, d, m, y) {
  # identify qualified monitors and merged it with dt (daily dataset)
  dt.c <- dt %>%
    mutate(Year = year(Date),
           Month = month(Date)) %>% 
    group_by(Monitor.ID, Year, Month) %>%
    summarize(n_Day = length(unique(Date))) %>%
    filter(n_Day >= d
    ) %>% #monitors wt at least -d- days each month 
    group_by(Monitor.ID, Year) %>%
    summarize(n_Month = length(unique(Month))) %>%
    filter(n_Month >= m
    ) %>% #monitors wt at least -m- month each year
    group_by(Monitor.ID) %>%
    summarize(n_Year = length(unique(Year))) %>%
    filter(n_Year >= y
    ) %>% #monitors wt at least -y- year in start-end period
    merge(dt
    ) %>% 
    select(-n_Year)
  return(dt.c)
}