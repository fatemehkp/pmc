### Author: Fatemeh Kazemi - 01-01-2021

# Function that Downloads and cleans air quality data measured by EPA 
# https://aqs.epa.gov/aqsweb/airdata/download_files.html

# EPA_AQS_download Function
# Function Arguments: 
# period : daily
# Index : list of file index to download
# start : start year 
# end : end year
# Code.Sym : list of parameters code and symbol ...
# ... ~Parameter.Code ~Parameter.Symbol
# Packages: tidyverse, lubridate

library(tidyverse)
library(lubridate)

EPA.AQS.download <- function(period, Index, start, end,
                             Code.Sym) {
  dt = data.frame()
  for (i in Index) {
    for (t in start:end) {
      temp <- tempfile()
      download.file(paste("https://aqs.epa.gov/aqsweb/airdata/",period,"_",i,"_",t
                          ,".zip",sep = ""),temp)
      dt0 <- read.csv(unz(temp, paste(period,"_",i,"_",t,".csv", sep = ""))) %>% 
        filter(Parameter.Code %in% Code.Sym$Parameter.Code) %>% 
        mutate(State.Code = as.factor(sprintf("%02d", 
                                              as.numeric(as.character(State.Code))))
               )
      dt <- rbind(dt, dt0)
    }
  }
  
  dt <- dt %>% 
    filter(!State.Name %in% c("Alaska","Hawaii","Puerto Rico","Virgin Islands",
                              "Country Of Mexico","Canada") #remove nonCONUS
    ) %>%
    transmute(
      #unique ID for each Site: ss-ccc-nnnn
      Site.ID = as.factor(sprintf("%02d-%03d-%04d",
                                  as.numeric(as.character(State.Code)),
                                  County.Code, Site.Num)),
      POC,
      #unique ID for each Monitor: ss-ccc-nnnn-pp
      Monitor.ID = as.factor(sprintf("%02d-%03d-%04d-%02d",
                                     as.numeric(as.character(State.Code)),
                                     County.Code, Site.Num, POC)),
      Parameter.Code,
      Date = ymd(Date.Local),
      Arithmetic.Mean,
    ) %>%
    merge(Code.Sym
    ) %>%
    select(Site.ID, POC, Monitor.ID, Parameter.Symbol, everything()) %>% 
    arrange(Site.ID, POC, Parameter.Symbol, Date) 
  return(dt)
}


