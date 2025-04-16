# Are you having issues with the tigris and tidycensus packages?
# The census tiger line API has been down recently
# There is a patch to fetch data straight from the FTP
# To use it, you need to uninstall tidycensus and tigris and then reinstall
# the patched version of tigris direct from github using the devtools package

# Then reinstall tidycensus, and proceed as normal. Getting geometries does take longer this way,
# but it works!

remove.packages("tidycensus")
remove.packages("tigris")

library(tidyverse)
library(sf)

library(devtools)

install_github("walkerke/tigris")

library(tigris)

houstonHighways <-
tigris::primary_secondary_roads(state = "TX")

install.packages("tidycensus")

library(tidycensus)

# Your API key goes here - I fetch mine from a hidden file, so you need to paste yours
# in the `census_api_key` call
census_key <- read.table("~/GitHub/census_key.txt", quote="\"", comment.char="")
census_api_key(census_key[1] %>% as.character(), overwrite = TRUE)

acs_vars <- c("B02001_001E")

houstonPop11 <- get_acs(geography = "tract", 
                        variables = acs_vars, 
                        year = 2011,
                        state = 48, 
                        geometry = TRUE, 
                        output = "wide",
                        county=c("Harris COunty","San Jacinto","Montgomery","Liberty","Waller",
                                 "Austin","Chambers","Fort Bend","Brazoria","Galveston"))
