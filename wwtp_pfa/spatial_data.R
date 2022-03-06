
library(tidyverse)
library(here)
library(janitor)

### Manually adding Encina Wastewater Authority
encina <- data.frame(global_id = 'NPD100052058',
                     site_name = 'Encina Wastewater Authority',
                     latitude_decimal_degrees = 33.11671495315463,
                     longitude_decimal_degrees = -117.32169348355484)


### Organize data from CA Waterboards
wwtp_info <- read_csv(here('wwtp_pfa', 'data', 'facility_info.csv')) %>% 
  clean_names() %>% 
  select(global_id, site_name, latitude_decimal_degrees, longitude_decimal_degrees) %>% 
  filter(global_id %in% c('NPD100051494', 'NPD100051597', 'NPD100051525', 'NPD100051520',
                          'WDR100000408', 'WDR100001103', 'WDR100001153', 'WDR100001164',
                          'WDR100001158', 'WDR100001083', 'NPD10005195', 'NPD100051948',
                          'WDR100035884', 'NPD10005205', 'NPD100051514', 'WDR100035948',
                          'WDR100030237', 'NPD100051499', 'WDR100032535', 'NPD100051624',
                          'NPD100051952', 'WDR100000191')) %>% 
  distinct(global_id, .keep_all = TRUE) %>% ### removes duplicates
  rbind(encina) ### adds the encina dataframe to the spatial data

### Alphabetize the data
wwtp_info <- wwtp_info[order(wwtp_info$site_name), ]

### Population Served
# population <- c(
  # Camrosa 
  #30000,
  # Carpinteria,
  #15619,
  # San Clemente
  #51522,
  # Tillman
  #800000,
  
  # Hyperion
  #4e6,
  #)



