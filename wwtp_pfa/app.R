
library(shiny)
library(tidyverse)


ui <- fluidPage(
                
                navbarPage('App Name',
                           
                           
                           tabPanel('Background'),
                           
                           
                           tabPanel('Widget 1',
                                    sidebarLayout(
                                      sidebarPanel(
                                        
                                        selectInput(
                                          "select_location", label = h3("Select Location"),
                                          choices = unique(pfa_data_final$wwtp)), # end select input
                                        
                                        checkboxGroupInput(
                                          "select_pt", label = h3("Select Sampling Location"),
                                          choices = unique(pfa_data_final$field_pt_name)) # end checkboxGroupInput
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
  
  location_reactive <- reactive({
    pfa_data_final %>% 
      filter(wwtp %in% input$select_location)})
  
  wwtp_reactive <- reactive({
    pfa_data_final %>% 
      filter(field_pt_name %in% input$select_pt)
  })
  
} # end server


shinyApp(ui = ui, server = server)