# pmc
Long-term PM25 Components Exposure and Mortality\

1. Downloads and cleans EPA AQS Sites Description Files\
2. Downloads and cleans PM2.5 Speciation data measured by EPA\
3. Cleans PM2.5 component data - Imrpove Network\
4. Cleans PM2.5 components data - CSN Network\
5. Combines all available PM2.5 Components data\
6. Choose a subset of monitors on the basis of data availability\
7. Smooth data with 4df per year to fill small gaps\
  7.1 Do not smooth over more than 90 days of missing data\
  7.2 Divide data into coherent pieces instead\
8. Calculates yearly average of PM components by site and month\
  8.1 Require at least 350 values to compute yearly average from smoothed data\
9. Runs Factor Analysis to identify the emission sources (factors) of the particles