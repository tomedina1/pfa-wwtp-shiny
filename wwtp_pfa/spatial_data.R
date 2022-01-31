
library(tidyverse)
library(here)
library(janitor)
library(sf)
library(tmap)

wwtp_info <- read_csv(here('wwtp_pfa', 'data', 'facility_info.csv')) %>% 
  clean_names() %>% 
  select(global_id, reporting_year, site_name, latitude_decimal_degrees, longitude_decimal_degrees) %>% 
  filter(site_name %in% c('NPD100051494'))
