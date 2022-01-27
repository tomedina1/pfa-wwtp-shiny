
library(tidyverse)
library(here)
library(janitor)


### Hyperion WWTP (Los Angeles)
hyperion <- read_csv(here('wwtp_pfa','data','hyperion.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('5-MILE', 'RI-NORS', 'RI-NCOS', 'RI-NOS', 'RI-CWIS', 'RI-COS'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Hyperion')

  for(i in 1:length(hyperion$field_pt_name)){
  
    if(hyperion$field_pt_name[i] == '5-MILE'){
      hyperion$field_pt_name[i] = 'effluent'}
  
    else{
      hyperion$field_pt_name[i] = 'influent'}}


### San Jose Creek WRP (Whittier)
whittier <- read_csv(here('wwtp_pfa', 'data', 'whittier.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('WN_DCL_TER', 'WN_RAW'),
         parvq == '=',
         units == "NG/L") %>% 
  mutate(wwtp = 'San Jose Creek')

  for(i in 1:length(whittier$field_pt_name)){
  
    if(whittier$field_pt_name[i] == 'WN_DCL_TER'){
      whittier$field_pt_name[i] = 'effluent'}
  
    else{
      whittier$field_pt_name[i] = 'influent'}}


### Tillman (Los Angeles)
tillman <- read_csv(here('wwtp_pfa', 'data', 'tillman.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PW', 'RI'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Tillman')

  for(i in 1:length(tillman$field_pt_name)){
  
    if(tillman$field_pt_name[i] == 'PW'){
      tillman$field_pt_name[i] = 'effluent'}
  
    else{
      tillman$field_pt_name[i] = 'influent'}}


### Port of Long Beach (Los Angeles)
port <- read_csv(here('wwtp_pfa', 'data', 'portb.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFFLUENT', 'RI'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Port of Long Beach')

  for(i in 1:length(port$field_pt_name)){
  
    if(port$field_pt_name[i] == 'EFFLUENT'){
      port$field_pt_name[i] = 'effluent'}
  
    else{
      port$field_pt_name[i] = 'influent'}}


### LA-Glendale 
glendale <- read_csv(here('wwtp_pfa', 'data', 'glendale.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFFLUENT', 'RI'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Glendale')

  for(i in 1:length(glendale$field_pt_name)){
  
    if(glendale$field_pt_name[i] == 'EFFLUENT'){
      glendale$field_pt_name[i] = 'effluent'}
  
    else{
      glendale$field_pt_name[i] = 'influent'}}


### Michelson WWRF - Irvine
irvine <- read_csv(here('wwtp_pfa', 'data', 'irvine.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('MWRP FINAL', 'MWRP INF'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Irvine')

  for(i in 1:length(irvine$field_pt_name)){
  
    if(irvine$field_pt_name[i] == 'MWRP FINAL'){
      irvine$field_pt_name[i] = 'effluent'}
  
    else{
      irvine$field_pt_name[i] = 'influent'}}


### San Clemente WRF
sanclem <- read_csv(here('wwtp_pfa', 'data', 'sanclemente.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('CSCRECYCLE', 'CSCINF'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'San Clemente')

  for(i in 1:length(sanclem$field_pt_name)){
    
    if(sanclem$field_pt_name[i] == 'CSCRECYCLE'){
      sanclem$field_pt_name[i] = 'effluent'}
    
    else{
      sanclem$field_pt_name[i] = 'influent'}}
  

### Point Loma WWTP (San Diego)
loma <- read_csv(here('wwtp_pfa', 'data', 'pointloma.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PLE', 'PLR'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'Point Loma')

  for(i in 1:length(loma$field_pt_name)){
  
    if(loma$field_pt_name[i] == 'PLE'){
      loma$field_pt_name[i] = 'effluent'}
  
    else{
      loma$field_pt_name[i] = 'influent'}}


### Palm Springs WWTF
palmsprings <- read_csv(here('wwtp_pfa', 'data', 'palmsprings.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PSWWTF-EFF', 'PSWWTF-INF'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'Palm Springs')

  for(i in 1:length(palmsprings$field_pt_name)){
    
    if(palmsprings$field_pt_name[i] == 'PSWWTF-EFF'){
      palmsprings$field_pt_name[i] = 'effluent'}
    
    else{
      palmsprings$field_pt_name[i] = 'influent'}}


### Margaret H Chandler WWRF (San Bernardino)
sanbernardino <- read_csv(here('wwtp_pfa', 'data', 'sanbernardino.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-FD-GRAB', 'EFF-FS-GRAB', 'INF-FD-GRAB', 'INF-FS-GRAB'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'San Bernardino')

  for(i in 1:length(sanbernardino$field_pt_name)){
  
    if(sanbernardino$field_pt_name[i] %in% c('EFF-FD-GRAB', 'EFF-FS-GRAB')){
      sanbernardino$field_pt_name[i] = 'effluent'}
  
    else{
      sanbernardino$field_pt_name[i] = 'influent'}}


### Palmdale WRP
palmdale <- read_csv(here('wwtp_pfa', 'data', 'palmdale.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('PA-WRP-EFF', 'PA-WRP-INF'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'Palmdale')

  for(i in 1:length(palmdale$field_pt_name)){
  
    if(palmdale$field_pt_name[i] == 'PA-WRP-EFF'){
      palmdale$field_pt_name[i] = 'effluent'}
  
    else{
      palmdale$field_pt_name[i] = 'influent'}}


### Goleta SD WWTP
goleta <- read_csv(here('wwtp_pfa', 'data', 'goleta.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('FINAL EFF', 'INFLUENT'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Goleta')

  for(i in 1:length(goleta$field_pt_name)){
    
    if(goleta$field_pt_name[i] == 'FINAL EFF'){
      goleta$field_pt_name[i] = 'effluent'}
    
    else{
      goleta$field_pt_name[i] = 'influent'}}


### El Estero - Santa Barbara 
sb <- read_csv(here('wwtp_pfa', 'data', 'sb.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-001A', 'INF-01', 'INF-02', 'INF-03'),
         parvq == '=',
         units == 'NG/L') %>%
  mutate(wwtp = 'El Estero - SB')

  for(i in 1:length(sb$field_pt_name)){
    
    if(sb$field_pt_name[i] == 'EFF-001A'){
      sb$field_pt_name[i] = 'effluent'}
    
    else{
      sb$field_pt_name[i] = 'influent'}}
  

### Carpinteria SD WWTP
carpinteria <- read_csv(here('wwtp_pfa', 'data', 'carpinteria.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('M-001 A', 'M-INF'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Carpinteria')

  for(i in 1:length(carpinteria$field_pt_name)){
    
    if(carpinteria$field_pt_name[i] == 'M-001 A'){
      carpinteria$field_pt_name[i] = 'effluent'}
    
    else{
      carpinteria$field_pt_name[i] = 'influent'}}


### Ojai
ojai <- read_csv(here('wwtp_pfa', 'data', 'ojai.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFFLUENT', 'INFLUENT'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Ojai Valley')

  for(i in 1:length(ojai$field_pt_name)){
    
    if(ojai$field_pt_name[i] == 'EFFLUENT'){
      ojai$field_pt_name[i] = 'effluent'}
    
    else{
      ojai$field_pt_name[i] = 'influent'}}


### Lompoc
lompoc <- read_csv(here('wwtp_pfa', 'data', 'lompoc.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-001', 'INF-001'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Lompoc')

  for(i in 1:length(lompoc$field_pt_name)){
  
    if(lompoc$field_pt_name[i] == 'EFF-001'){
      lompoc$field_pt_name[i] = 'effluent'}
  
    else{
      lompoc$field_pt_name[i] = 'influent'}}


### Oxnard
oxnard <- read_csv(here('wwtp_pfa', 'data', 'oxnard.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('EFF-001B', 'INF-001'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Lompoc')

  for(i in 1:length(oxnard$field_pt_name)){
  
    if(oxnard$field_pt_name[i] == 'EFF-001B'){
      oxnard$field_pt_name[i] = 'effluent'}
  
    else{
      oxnard$field_pt_name[i] = 'influent'}}


### Valencia WWTP
valencia <- read_csv(here('wwtp_pfa', 'data', 'valencia.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('VAL_CL_TER', 'VAL_RAW'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Valencia')

  for(i in 1:length(valencia$field_pt_name)){
  
    if(valencia$field_pt_name[i] == 'VAL_CL_TER'){
      valencia$field_pt_name[i] = 'effluent'}
  
    else{
      valencia$field_pt_name[i] = 'influent'}}


### Encina (Carlsbad)
encina <- read_csv(here('wwtp_pfa', 'data', 'encina.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('M-001', 'INF-001'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'Encina')

  for(i in 1:length(encina$field_pt_name)){
  
    if(encina$field_pt_name[i] == 'M-001'){
      encina$field_pt_name[i] = 'effluent'}
  
    else{
      encina$field_pt_name[i] = 'influent'}}


### South San Diego
sd <- read_csv(here('wwtp_pfa', 'data', 'sd.csv')) %>% 
  clean_names() %>% 
  select(samp_date, field_pt_name, parameter:value, units) %>% 
  filter(field_pt_name %in% c('SB_OUTFALL', 'SB_REC_H2O', 'SB_INF_02'),
         parvq == '=',
         units == 'NG/L') %>% 
  mutate(wwtp = 'San Diego')

  for(i in 1:length(sd$field_pt_name)){
  
    if(sd$field_pt_name[i] %in% c('SB_OUTFALL', 'SB_REC_H20')){
    sd$field_pt_name[i] = 'effluent'}
  
    else{
      sd$field_pt_name[i] = 'influent'}}



### Generate final df used in the shiny app
pfa_data <- rbind(carpinteria, glendale, goleta, hyperion, irvine, loma, lompoc,
                  ojai, oxnard, palmdale, palmsprings, port, sanbernardino, sanclem,
                  sb, sd, tillman, whittier) ### binds all of the data frames together

pfa_data_final <- pfa_data %>% 
  group_by(wwtp, samp_date, field_pt_name, parameter) %>% 
  summarize(mean_value = mean(value)) %>% ### averages the concentration values when there is multiple influent or effluent concentrations
  pivot_wider(names_from = field_pt_name,
              values_from = mean_value) ### makes new columns for influent and effluent
  
  pfa_data_final[is.na(pfa_data_final)] <- 0 ### all NA values become 0
  
  
shiny_data <- pfa_data_final %>% 
  mutate(difference = effluent - influent, ### calculates a difference column
         formation = case_when( ### creates a column that tags if PFA formation occurs in the water treatment plant.
           difference < 0 ~ FALSE,
           difference > 0 ~ TRUE))

  for(i in 1:length(shiny_data$parameter)){
    
    if(shiny_data$parameter[i] == 'PFHA'){
      shiny_data$parameter[i] = 'PFHxA'}}


  