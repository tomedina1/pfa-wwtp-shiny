
### Parameters and parameter names
parameters <- data.frame(
  unique(pfa_data$parameter),
  unique(pfa_data$parameter_name))  %>% 
  rename(parameter = unique.pfa_data.parameter.,
         parameter_name = unique.pfa_data.parameter_name.)


  for (i in 1:length(parameters$parameter)){
    
    if (parameters$parameter[i] == 'PFHA'){
      parameters$parameter[i] = 'PFHxA'}
    
  }


