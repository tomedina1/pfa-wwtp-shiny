
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
  mutate(wwtp = 'Los Angeles - Hyperion')

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
  mutate(wwtp = 'Whittier - San Jose Creek')

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
  mutate(wwtp = 'Los Angeles - Tillman')

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
  mutate(wwtp = 'Port of Long Beach - Los Angeles')

for(i in 1:length(port$field_pt_name)){
  
  if(port$field_pt_name[i] == 'EFFLUENT'){
    port$field_pt_name[i] = 'effluent'}
  
  else{
    port$field_pt_name[i] = 'influent'}}
  
