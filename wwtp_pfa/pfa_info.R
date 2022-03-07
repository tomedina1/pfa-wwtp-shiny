
library(tidyverse)

### Parameters and parameter names
pfa_data <- read_csv(here('wwtp_pfa', 'pfa.csv'))

parameters <- data.frame(
  unique(pfa_data$parameter),
  unique(pfa_data$parameter_name))  %>% 
  rename(parameter = unique.pfa_data.parameter.,
         parameter_name = unique.pfa_data.parameter_name.)


### attach molar mass to df
molar_mass <- c(395.10, 557.23, 585.24, 571.21, 300.10, 214.04, 314.05, 364.06,
                400.12, 464.08, 514.08, 414.07, 500.13, 264.05, 350.11, 528.18,
                614.10, 600.15, 714.11, 564.09, 450.12, 527.20, 664.10, 428.17,
                550.14, 499.15, 342.11, 330.05, 571.25, 328.15, 814.13)


### attach chem formulas to df
chem_formula <- c('C7H5F12NO4', 'C11H8F17NO3S', 'C12H8F17NO4S', 'C11H6F17NO4S',
                      'C4HF9O3S', 'C4HF7O2', 'C6HF11O2', 'C7HF13O2', 'C6HF13O3S',
                      'C9HF17O2', 'C10HF19O2', 'C8HF15O2', 'C8HF17O3S', 'C5HF9O2',
                      'C5HF11O3S', 'C10H517O3S', 'C12HF23O2', 'C10HF21O3S', 
                      'C14HF27O2', 'C11HF21O2', 'C7HF15O3S', 'C10H6F17NO2S',
                      'C13HF25O2', 'C8H5F13O3S', 'C9HF19O3S', 
                      'C8H2F17NO2S', 'C8H5F11O2', 'C6HF11O3', 'C12H10F17NO3S',
                      'C6H5F9O3S', 'C16HF31O2')


parameters <- cbind(parameters, molar_mass, chem_formula) ### bind columns

parameters <- parameters[order(molar_mass), ] ### order columns by molar mass (smallest - greatest)
