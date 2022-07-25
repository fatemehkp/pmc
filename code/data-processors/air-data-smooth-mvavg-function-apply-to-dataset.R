 

library(tidyverse)
# the dt.air should have these columns:
# "Site.ID", "Date", "Parameter.Symbol", "Value"


site.para <- dt.air %>% 
  distinct(Site.ID, Parameter.Symbol)

#using smoothed.yr function
smooth.out <- mapply(Smoothed.Year, 
                     site.para$Site.ID, site.para$Parameter.Symbol, 0.99, 350)
para.monthly <- data.frame(Site.ID=unlist(smooth.out[1,]),
                           Parameter.Symbol=unlist(smooth.out[2,]),
                           Date=unlist(smooth.out[3,]), 
                           para.1yr=unlist(smooth.out[4,]))

dt.pmc.1yr <- para.monthly %>% 
  mutate(Year = floor(Date -0.01),
         Month = round((Date - Year)*12)) %>% 
  select(-Date) %>% 
  pivot_wider(names_sort = T,
              names_from = c(Parameter.Symbol),
              values_from = c(para.1yr)) %>% 
  arrange(Site.ID, Year, Month)