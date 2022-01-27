
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
                            
                                      ), # end sidebarPanel
                                      
                                      mainPanel("Output goes here",
                                        plotOutput("pfa_plot")
                                      ) # end mainPanel
                                    
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
      filter(wwtp == input$select_location)})
  
  
  output$pfa_plot <- renderPlot(
    ggplot(data = location_reactive(), aes(x = parameter, y = mean_value, fill = field_pt_name)) +
      geom_bar(stat = 'identity', position = 'dodge') +
      facet_wrap(~ samp_date) +
      theme_classic())

  
  
  
} # end server


shinyApp(ui = ui, server = server)