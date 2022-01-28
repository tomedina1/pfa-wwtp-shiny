
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
                                          choices = unique(pfa_data_final$wwtp)), 
                                        
                                        selectizeInput(
                                          "select_date", label = h3("Select Sampling Date"),
                                          choices = unique(pfa_data_final$samp_date)),
                            
                                      ), # end sidebarPanel
                                      
                                      mainPanel(
                                        plotOutput("pfa_plot")
                                      ) # end mainPanel
                                    
                                      ) # end sidebarLayout
                                    ), # end tabPanel
                           
                           
                           tabPanel('Widget 2',
                                    sidebarLayout(
                                      sidebarPanel(
                                        
                                        selectInput(
                                          "select_location_2", label = h3("Select Location"),
                                          choices = unique(shiny_data_final$wwtp)),
                                        
                                        selectizeInput(
                                          "select_date_2", label = h3("Select Sampling Date"),
                                          choices = unique(shiny_data_final$samp_date))
                                        
                                      ), # end sidebarPanel
                                      
                                      mainPanel(
                                        plotOutput("pfa_difference")
                                      ) # end mainPanel
                                      
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

  ### WIDGET 1
  location_reactive <- reactive({
    pfa_data_final %>% 
      filter(wwtp == input$select_location)})
  
  date_reactive <- reactive({
    location_reactive %>% 
      filter(date == input$select_date)})
  
  
  observeEvent(input$select_location,
                {updateSelectizeInput(session, input = "select_date",
                                      choices = pfa_data_final[pfa_data_final$wwtp %in% input$select_location, 
                                                              "samp_date", drop = TRUE])})

  plot_data <- reactive({
    pfa_data_final %>% 
    filter(wwtp == input$select_location,
           samp_date == input$select_date)})
 
 
  output$pfa_plot <- renderPlot({
    ggplot(data = plot_data(), aes(x = parameter, y = mean_value, fill = field_pt_name)) +
      geom_bar(stat = 'identity', position = position_dodge2(preserve = "single"), width = 0.5) +
      guides(fill = guide_legend(title = 'sample location')) +
      labs(x = "PFA",
           y = "concentration (ng/L)") +
      theme_minimal()})
  
  
  ### WIDGET 2
  location_reactive_2 <- reactive({
    shiny_data_final %>% 
      filter(wwtp == input$select_location_2)})
  
  date_reactive_2 <- reactive({
    location_reactive_2 %>% 
      filter(date == input$select_date_2)})
  
  observeEvent(input$select_location_2,
               {updateSelectizeInput(session, input = "select_date_2",
                                     choices = shiny_data_final[shiny_data_final$wwtp %in% input$select_location_2,
                                                                "samp_date", drop = TRUE])})
  
  plot_data_2 <- reactive({
    shiny_data_final %>% 
      filter(wwtp == input$select_location_2,
             samp_date == input$select_date_2) %>% 
      na.omit()})
  
  output$pfa_difference <- renderPlot({
    ggplot(data = plot_data_2(), aes(x = parameter, y = difference)) +
      geom_bar(stat = 'identity', width = 0.5) +
      labs(x = "PFA",
           y = "Concentration difference (ng/L)") +
      theme_minimal()}) 
  
  
} # end server


shinyApp(ui = ui, server = server)