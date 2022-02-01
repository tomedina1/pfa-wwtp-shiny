
library(tidyverse)
library(here)
library(janitor)

### Get coordinates for ENCINA!!!

wwtp_info <- read_csv(here('wwtp_pfa', 'data', 'facility_info.csv')) %>% 
  clean_names() %>% 
  select(global_id, reporting_year, site_name, latitude_decimal_degrees, longitude_decimal_degrees) %>% 
  filter(global_id %in% c('NPD100051494', 'NPD100051597', 'NPD100051525', 'NPD100051520',
                          'WDR100000408', 'WDR100001103', 'WDR100001153', 'WDR100001164',
                          'WDR100001158', 'WDR100001083', 'NPD10005195', 'NPD100051948',
                          'WDR100035884', 'NPD10005205', 'NPD100051514', 'WDR100035948',
                          'WDR100030237', 'NPD100051499', 'WDR100032535', 'NPD100051624')) %>% 
  mutate(county = case_when(
    global_id %in% c('NPD100051494', 'NPD100051597', 'NPD100051525','NPD100051624') ~ 'Santa Barbara County',
    global_id %in% c('NPD100051520','WDR100000408') ~ 'Ventura County',
    global_id %in% c('WDR100001103', 'WDR100001153', 'WDR100001158','WDR100001083', 'WDR100030237', 'WDR100001164') ~ 'Los Angeles County',
    global_id %in% c('NPD100051948','WDR100035884') ~ 'Orange County',
    global_id %in% c('NPD100051514', 'WDR100035948') ~ 'San Diego County',
    global_id == 'WDR100032535' ~ 'Riverside County',
    global_id == 'NPD100051499' ~ 'San Bernardino County'))



