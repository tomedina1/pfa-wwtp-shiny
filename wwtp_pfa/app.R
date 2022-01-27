
library(shiny)
library(tidyverse)


ui <- fluidPage(
                
                navbarPage('App Name',
                           
                           
                           tabPanel('Background'),
                           
                           
                           tabPanel('Widget 1',
                                    sidebarLayout(
                                      sidebarPanel(
                                        
                                        selectInput(
                                          "wwtp", label = h3("Select Location"),
                                          choices = list('Carpinteria' = 'Carpinteria', 'El Estero - Santa Barbara' = 'Santa Barbara',
                                                         'LA/Glendale' = 'Glendale', 'Goleta' = 'Goleta', 
                                                         'Hyperion - Los Angeles' = 'Hyperion', 'Michelson - Irvine' = 'Irvine',
                                                         'Lompoc' = 'Lompoc', 'Ojai Valley' = 'Ojai Valley', 
                                                         'Palm Springs' = 'Palm Springs', 'Palmdale' = 'Palmdale',
                                                         'Coronado Island' = 'Point Loma', 'Port of Long Beach' = 'Port of Long Beach',
                                                         'San Bernardino' = 'San Bernardino', 'San Clemente' = 'San Clemente',
                                                         'San Diego' = 'San Diego', 'Whittier' = 'Whittier',
                                                         'Tillman - Los Angeles' = 'Tillman', 'Carlsbad' = 'Encina',
                                                         'Santa Clarita' = 'Valencia')), # end select input
                                        
                                        checkboxGroupInput(
                                          "field_pt_name", label = h3("Select Sampling Location"),
                                          choices = list('influent' = 'influent', 'effluent' = 'effluent')) # end checkboxGroupInput
                                      ), # end sidebarPanel
                                      
                                      mainPanel('output goes here') # end mainPanel
                                    
                                      ) # end sidebarLayout
                                    ), # end tabPanel
                           
                           
                           tabPanel('Widget 2',
                                    sidebarLayout(
                                      sidebarPanel('Widget goes here'), # end sidebarPanel
                                      
                                      mainPanel('output goes here') # end mainPanel
                                      
                                    ) # end sidebarLayout
                           ), # end tabPanel
                           
                           
                           tabPanel('Widget 3',
                                    sidebarLayout(
                                      sidebarPanel('Widget goes here'), # end sidebarPanel
                                      
                                      mainPanel('output goes here') # end mainPanel
                                      
                                    ) # end sidebarLayout
                           ), # end tabPanel
                           
                           
                           tabPanel('References'),
                           
                           
                           tabPanel('Contact')
                           
                           
                           ) # end navbarPage
                ) # end ui


server <- function(input, output){
  
  output$wwtp <- renderPrint({pfa_data_final$wwtp})
  
  output$field_pt_name <- renderPrint({pfa_data_final$field_pt_name})
  
} # end server


shinyApp(ui = ui, server = server)