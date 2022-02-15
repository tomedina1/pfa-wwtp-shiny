
library(tidyverse)

### Parameters and parameter names
parameters <- data.frame(
  unique(pfa_data$parameter),
  unique(pfa_data$parameter_name))  %>% 
  rename(parameter = unique.pfa_data.parameter.,
         parameter_name = unique.pfa_data.parameter_name.) %>% 
  mutate(pfa_type = case_when(
    grepl('sulf', parameter_name) ~ 'Perfluorosulfonic Acid',
    TRUE ~ 'Perfluorocarboxylic Acid'))


molar_mass <- c(395.10, 557.23, 585.24, 571.21, 300.10, 
                214.04, 314.05, 364.06, 400.12, 464.08,
                514.08, 414.07, 500.13, 264.05, 350.11,
                528.18, 614.10, 600.15, 714.11, 564.09,
                450.12, 500.13, 527.2, 664.1, 428.17,
                214.04, 334.2, 438.21, 550.14, 499.15,
                342.11, 330.05, 571.25, 328.15, 814.13)


parameters <- cbind(parameters, molar_mass)