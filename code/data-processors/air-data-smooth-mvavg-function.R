### Author:  Sonja Greven, 17 June 2009 
### Modified: Fatemeh Kazemi, 27 Dec 2020

library(tidyverse)
library(lubridate)
library(mgcv)

# Smoothed.Year Function
# Smooths data with 4df per year to fill small gaps
# Does not smooth over more than 90 days of missing data
# Divides data into coherent pieces instead
# Smooth
# dt.air: contains air quality data by monitor site and day
#    Site.ID:
#    Parameter.Symbol
#    Value:
#    Date:

Smoothed.Year <- function(si, pr){ 

    dt <- dt.air %>% 
    filter(Site.ID == si & Parameter.Symbol == pr) %>%
    select(Site.ID, Parameter.Symbol, Value, Date) %>% 
    mutate(year = year(Date),
           month = month(Date),
           date2 = as.numeric(as.Date(Date))) %>% 
    arrange(date2)
  
  gaps <- dt$date2[2:nrow(dt)]-dt$date2[1:(nrow(dt)-1)]
  cuts <- c(0,which(gaps>90),nrow(dt))  #cut data into coherent bits with gaps <=90 days
  n.bits <- length(cuts)-1
  rows <- max(dt$year+dt$month/12)*12-12*min(dt$year+dt$month/12)+1
  results <- data.frame(Site.ID=rep(si,rows), Parameter.Symbol=rep(pr,rows), 
                        Date=rep(NA,rows),mvavg.1yr=rep(NA,rows))
  rows <- 0

  for (c in 1:n.bits){
    dt1 <- dt[(cuts[c]+1):cuts[c+1],]
    if (nrow(dt1)>10){ #only try smoothing with at least 11 values
      df <- ceiling((max(dt1$date2)- min(dt1$date2))/365*4) #4 df per year
      if (df<4){print(paste("Site.ID: ",si,", Para: ",pr,", c: ",c,", df: ",df,sep=""))}
      gres <- gam(Value~s(date2,fx=TRUE,k=df+1),data=dt1)
      
      pred.data <- as.data.frame(seq(min(dt1$date2),max(dt1$date2)))
      colnames(pred.data) <- c("date2")
      pred.data$smooth <- predict(gres,pred.data)
      pred.data$year <- year(as.Date(pred.data$date2, origin = "1970-01-01"))
      pred.data$month <- month(as.Date(pred.data$date2, origin = "1970-01-01"))
      pred.data$day <- day(as.Date(pred.data$date2, origin = "1970-01-01"))
      pred.data$date <- pred.data$year + pred.data$month/12
      dtdate <- unique(pred.data$date)
      
      average1 <- function(dat){
        av <- subset(pred.data,pred.data$date<=dat+0.01 & pred.data$date >dat-0.99)
        if (nrow(av)>=350){mean.value <- mean(av$smooth)}else{mean.value <- NA}
        return(mean.value)
      }
      smoothed.yr <- sapply(dtdate,average1)
      
      results[(rows+1):(rows+length(dtdate)),"Date"] <- dtdate
      results[(rows+1):(rows+length(dtdate)),"mvavg.1yr"] <- smoothed.yr
      rows <- rows + length(dtdate)
    }}
  results <- results[!is.na(results$mvavg.1yr),]
  return(results)
}