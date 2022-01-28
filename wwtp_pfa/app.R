
library(shiny)
library(tidyverse)
library(patchwork)


ui <- fluidPage(
                
                navbarPage('App Name',
                           
                           
                           tabPanel('Background'),
                           
                           
                           tabPanel('Widget 1',
                                    sidebarLayout(
                                      sidebarPanel(
                                        
                                        selectInput(
                                          "select_location", label = h3("Select Location"),
                                          choices = unique(pfa_data_final$wwtp)), # end select input
                                        
                                        selectizeInput(
                                          "select_date", label = h3("Select sampling date"),
                                          choices = unique(pfa_data_final$samp_date))
                            
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


server <- function(input, output, session){
  
  location_reactive <- reactive({
    pfa_data_final %>% 
      filter(wwtp == input$select_location)})
  
  date_reactive <- reactive({
    location_reactive %>% 
      filter(date == input$select_date)})
  
  
 observeEvent(input$select_location,
              {
   updateSelectizeInput(session,
                        input = "select_date",
                        choices = pfa_data_final[pfa_data_final$wwtp %in% input$select_location, "samp_date", drop = TRUE])})
 
 plot_data <- reactive({
   pfa_data_final %>% 
   filter(wwtp == input$select_location,
          samp_date == input$select_date)})
 
 output$pfa_plot <- renderPlot({

   ggplot(data = plot_data(), aes(x = parameter, y = mean_value, fill = field_pt_name)) +
     geom_bar(stat = 'identity', position = 'dodge', width = 0.5) +
     theme_minimal()})
                
                
 

  

  
  
  
} # end server


shinyApp(ui = ui, server = server)