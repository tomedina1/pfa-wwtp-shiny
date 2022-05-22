
library(tidyverse)
library(here)
library(janitor)
library(lubridate)


### Hyperion WWTP (Los Angeles)
hyperion <- read_csv(here('wwtp_pfa','data','hyperion.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('5-MILE', 'RI-NORS', 'RI-NCOS', 'RI-NOS', 'RI-CWIS', 'RI-COS'),
         parvq == '=',
         units == 'NG/L',
         !(samp_date %in% c('10/14/2020', '9/14/2021'))) %>% 
  mutate(wwtp = 'Hyperion Wastewater Treatment Plant',
         field_pt_name = ifelse(field_pt_name == '5-MILE', 'effluent', "influent")) 

### San Jose Creek WRP (Whittier)
whittier <- read_csv(here('wwtp_pfa', 'data', 'whittier.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('WN_DCL_TER', 'WN_RAW'),
         parvq == '=',
         units == "NG/L") %>% 
  mutate(wwtp = 'San Jose Creek Water Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'WN_DCL_TER', 'effluent', 'influent'))

### Tillman (Los Angeles)
tillman <- read_csv(here('wwtp_pfa', 'data', 'tillman.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PW', 'RI'),
         parvq == '=',
         units == 'NG/L',
         samp_date != '10/14/2020') %>% 
  mutate(wwtp = 'Donald C. Tillman Wastewater Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'PW', 'effluent', 'influent'))

### Port of Long Beach (Los Angeles)
port <- read_csv(here('wwtp_pfa', 'data', 'portb.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFFLUENT', 'RI'),
         parvq == '=',
         units == 'NG/L',
         samp_date != '10/14/2020') %>% 
  mutate(wwtp = 'Terminal Island Water Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'EFFLUENT', 'effluent', 'influent'))

### LA-Glendale 
glendale <- read_csv(here('wwtp_pfa', 'data', 'glendale.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFFLUENT', 'RI'),
         parvq == '=',
         units == 'NG/L',
         samp_date != '10/14/2020') %>% 
  mutate(wwtp = 'Los Angeles-Glendale Wastewater Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'EFFLUENT', 'effluent', 'influent'))

### Michelson WWRF - Irvine
irvine <- read_csv(here('wwtp_pfa', 'data', 'irvine.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('MWRP FINAL', 'MWRP INF'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Michelson Wastewater Reclamation Facility',
         field_pt_name = ifelse(field_pt_name == 'MWRP FINAL', 'effluent', 'influent'))

### San Clemente WRF
sanclem <- read_csv(here('wwtp_pfa', 'data', 'sanclemente.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('CSCRECYCLE', 'CSCINF'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'City of San Clemente Wastewater Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'CSCRECYCLE', 'effluent', 'influent'))

### Point Loma WWTP (San Diego)
loma <- read_csv(here('wwtp_pfa', 'data', 'pointloma.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PLE', 'PLR'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'Point Loma Wastewater Treatment Plant',
         field_pt_name = ifelse(field_pt_name == 'PLE', 'effluent', 'influent'))

### Palm Springs WWTF
palmsprings <- read_csv(here('wwtp_pfa', 'data', 'palmsprings.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PSWWTF-EFF', 'PSWWTF-INF'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'Palm Springs Wastewater Treatment Facility',
         field_pt_name = ifelse(field_pt_name == 'PSWWTF-EFF', 'effluent', 'influent'))

### Margaret H Chandler WWRF (San Bernardino)
sanbernardino <- read_csv(here('wwtp_pfa', 'data', 'sanbernardino.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-FD-GRAB', 'EFF-FS-GRAB', 'INF-FD-GRAB', 'INF-FS-GRAB'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'Margaret H. Chandler Wastewater Reclamation Facility',
         field_pt_name = ifelse(field_pt_name %in% c('EFF-FD-GRAB', 'EFF-FS-GRAB'), 'effluent', 'influent'))

### Palmdale WRP
palmdale <- read_csv(here('wwtp_pfa', 'data', 'palmdale.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PA-WRP-EFF', 'PA-WRP-INF'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'Palmdale Water Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'PA-WRP-EFF', 'effluent', 'influent'))

### Goleta SD WWTP
goleta <- read_csv(here('wwtp_pfa', 'data', 'goleta.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('FINAL EFF', 'INFLUENT'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Goleta Sanitation District Wastewater Treatment Plant',
         field_pt_name = ifelse(field_pt_name == 'FINAL EFF', 'effluent', 'influent'))

### El Estero - Santa Barbara 
sb <- read_csv(here('wwtp_pfa', 'data', 'sb.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-001A', 'INF-01', 'INF-02', 'INF-03'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'El Estero Water Resource Center',
         field_pt_name = ifelse(field_pt_name == 'EFF-001A', 'effluent', 'influent'))

### Carpinteria SD WWTP
carpinteria <- read_csv(here('wwtp_pfa', 'data', 'carpinteria.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('M-001 A', 'M-INF'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Carpinteria Sanitation District Wastewater Treatment Plant',
         field_pt_name = ifelse(field_pt_name == 'M-001 A', 'effluent', 'influent'))

### Ojai
ojai <- read_csv(here('wwtp_pfa', 'data', 'ojai.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFFLUENT', 'INFLUENT'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Ojai Valley Wastewater Treatment Plant',
         field_pt_name = ifelse(field_pt_name == 'EFFLUENT', 'effluent', 'influent'))

### Lompoc
lompoc <- read_csv(here('wwtp_pfa', 'data', 'lompoc.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-001', 'INF-001'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Lompoc City Wastewater Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'EFF-001', 'effluent', 'influent'))

### Oxnard
oxnard <- read_csv(here('wwtp_pfa', 'data', 'oxnard.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-001B', 'INF-001'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Oxnard Wastewater Treatment Plant',
         field_pt_name = ifelse(field_pt_name == 'EFF-001B', 'effluent', 'influent'))

### Valencia WWTP
valencia <- read_csv(here('wwtp_pfa', 'data', 'valencia.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('VAL_CL_TER', 'VAL_RAW'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Valencia Water Reclamation Plant',
         field_pt_name = ifelse(field_pt_name == 'VAL_CL_TER', 'effluent', 'influent'))

### Encina (Carlsbad)
encina <- read_csv(here('wwtp_pfa', 'data', 'encina.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('M-001', 'INF-001'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Encina Wastewater Authority',
         field_pt_name = ifelse(field_pt_name == 'M-001', 'effluent', 'influent'))

### South San Diego
sd <- read_csv(here('wwtp_pfa', 'data', 'sd.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('SB_OUTFALL', 'SB_REC_H2O', 'SB_INF_02'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'South Bay Water Reclamation Plant',
         field_pt_name = ifelse(field_pt_name %in% c('SB_OUTFALL', 'SB_REC_H20'), 'effluent', 'influent'))

### Camrosa
camrosa <- read_csv(here('wwtp_pfa', 'data', 'camrosa.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-002', 'INF-001', 'INF-002'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Camrosa Water Reclamation Facility',
         field_pt_name = ifelse(field_pt_name == 'EFF-001', 'effluent', 'influent'))

### Generate final df used in the shiny app
pfa_data <- rbind(carpinteria, encina, glendale, goleta, hyperion, irvine, loma, lompoc,
                  ojai, oxnard, palmdale, palmsprings, port, sanbernardino, sanclem,
                  sb, sd, tillman, valencia, whittier, camrosa) %>%   ### binds all of the data frames together
  mutate(parameter = case_when( ### adjust naming convention to standard
    parameter == 'PFOS_A' ~ 'PFOS',
    parameter == 'PFHA' ~ 'PFHxA',
    parameter == 'PFOSA' ~ 'FOSA',
    parameter == 'HFPA-DA' ~ 'GenX',
    parameter == 'PFBTA' ~ 'PFBA',
    parameter == 'PFDSA' ~ 'PFDS',
    parameter == 'PFHPA' ~ 'PFHpA',
    parameter == 'PFHPSA' ~ 'PFHpS',
    parameter == 'PFHXDA' ~ 'PFHxDA',
    parameter == 'PFHXS' ~ 'PFHxS',
    parameter == 'PFHXSA' ~ 'PFHxS',
    parameter == 'PFNDCA' ~ 'PFDA',
    parameter == 'PFTRIDA' ~ 'PFTrDA',
    parameter == 'PFUNDCA' ~ 'PFUnA',
    parameter == 'PFDOA' ~ 'PFDoA',
    parameter == 'PFBSA' ~ 'PFBS',
    parameter == 'PFTEDA' ~ 'PFTA',
    TRUE ~ parameter),
    
    parameter_name = case_when( ### adjust naming convention to standard
      parameter_name == 'Perfluorohexane sulfonate' ~ 'Perfluorohexanesulfonic acid',
      parameter_name == 'Perfluorooctanoic sulfonate' ~ 'Perfluorooctane sulfonic acid',
      parameter_name == 'Perfluorobutane sulfonate' ~ 'Perfluorobutanesulfonic acid',
      parameter_name == 'Perfluorobutanoic acid' ~ 'Perfluorobutyric acid',
      TRUE ~ parameter_name))
  

pfa_data_final <- pfa_data %>% 
  group_by(wwtp, samp_date, field_pt_name, parameter) %>% 
  summarize(mean_value = mean(value)) %>% ### averages the concentration values when there is multiple influent or effluent concentrations
  mutate(field_pt_name = factor(field_pt_name),
         field_pt_name = fct_rev(field_pt_name), 
         samp_date = mdy(samp_date)) ### converts date column to date class


shiny_data <- pfa_data_final %>% 
  pivot_wider(names_from = field_pt_name,
              values_from = mean_value) ### makes new columns for influent and effluent
  
  pfa_data_final[is.na(pfa_data_final)] <- 0 ### all NA values become 0
  shiny_data[is.na(shiny_data)] <- 0
  
  
shiny_data_final <- shiny_data %>% 
  mutate(difference = effluent - influent, ### calculates a difference column
         formation = case_when( ### creates a column that tags if PFA formation occurs in the water treatment plant.
           difference < 0 ~ FALSE,
           difference > 0 ~ TRUE)) %>% 
  filter(formation == TRUE,
         difference > 2) ### significant concentration difference

### csv output of data for shiny app download
write_csv(pfa_data, 'pfa.csv')
write_csv(pfa_data_final, 'pfa_data.csv')
write_csv(shiny_data_final, 'difference_data_pfas.csv')
  