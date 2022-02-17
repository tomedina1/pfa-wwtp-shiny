
library(shiny)
library(tidyverse)
library(leaflet)
library(shinyWidgets)
library(bslib)
library(plotly)


source('data_wrangling.R')
source('spatial_data.R')
source('pfa_info.R')


my_theme <- bs_theme(bootswatch = "lux")


ui <- fluidPage(theme = my_theme,
              
                
                navbarPage('PFA Tracker',
                           
                           tabPanel('Background',
                                    sidebarLayout(
                                      sidebarPanel(width = 3,
                                                
                                                  sliderInput("mass_range",
                                                              label = h3('Select a mass range'),
                                                              min = 210,
                                                              max = 815,
                                                              value = c(390, 610),
                                                              ticks = FALSE,
                                                              sep = "")
                                                  
                                                  ),
                                      
                                      
                                      mainPanel(
                                        dataTableOutput("pfadt")
                                      )
                                      
                                    )
                                    
                                    ),
                           
                           
                           tabPanel('WWTP Map',
                                    sidebarLayout(
                                      sidebarPanel(width = 3,
                                        
                                        
                                        prettyCheckboxGroup("select_site", label = h3("Select Treatment Site"),
                                                           choices = unique(wwtp_info$site_name),
                                                           plain = TRUE,
                                                           fill = TRUE,
                                                           icon = icon("fas fa-check"),
                                                           animation = 'smooth'),
                                        actionButton("selectall", label = "Select / Deselect all")
                                        
                                        ), # end sidebarPanel
                                 
                                      
                                  
                                    mainPanel(
                                      leafletOutput("map", height = 700)
                                      ) # end mainPanel 
                                    
                                    ) # end sidebarLayout
                                    
                                    ), # end tabPanel
                           
                           
                           tabPanel('PFA Concentrations',
                                    sidebarLayout(
                                      sidebarPanel(
                                        
                                        selectInput(
                                          "select_location", label = h3("Select Location"),
                                          choices = unique(pfa_data_final$wwtp)), 
                                        
                                        selectizeInput(
                                          "select_date", label = h3("Select Sampling Date"),
                                          choices = unique(pfa_data_final$samp_date))
                            
                                      ), # end sidebarPanel
                                      
                                      mainPanel(
                                        plotlyOutput("pfa_plot", height = 700)
                                      ) # end mainPanel
                                    
                                      ) # end sidebarLayout
                                    
                                    ), # end tabPanel
                           
                           
                           tabPanel('PFA Formation',
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
                                        plotlyOutput("pfa_difference", height = 700)
                                      ) # end mainPanel
                                      
                                    ) # end sidebarLayout
                                    
                           ), # end tabPanel
                           
                           
                           tabPanel('References'),
                           
                           
                           tabPanel('Contact')
                           
                           
                           ) # end navbarPage

                ) # end ui


server <- function(input, output, session){
  
  ### BACKGROUND
  
  
  output$pfadt <- renderDataTable({
    dt <- parameters[parameters$molar_mass >= input$mass_range[1] & parameters$molar_mass <= input$mass_range[2], ]
    
  },
  
  options = list(
    pageLength = 35,
    info = FALSE,
    dom = 'ft',
    columns = list(
      list(title = 'PFA'),
      list(title = 'Chemical Name'),
      list(title = 'Molar Mass (g/mol)'),
      list(title = 'Chemical Formula'))
  ))
  
  

  
  ### WIDGET 1
  map_reactive <- reactive({
    wwtp_info %>% 
      filter(site_name %in% input$select_site)
    })
  
  
  observeEvent(input$selectall,
               {if (input$selectall > 0) {
                   
                   if (input$selectall %% 2 == 0){
                     updatePrettyCheckboxGroup(session = session, 
                                               inputId = "select_site",
                                               choices = unique(wwtp_info$site_name),
                                               selected = c(unique(wwtp_info$site_name)),
                                               prettyOptions = list(animation = 'smooth',
                                                                    plain = TRUE,
                                                                    fill = TRUE,
                                                                    icon = icon('fas fa-check'))
                                               )}
                 
                   else {
                     updatePrettyCheckboxGroup(session = session, 
                                               inputId = "select_site",
                                               choices = unique(wwtp_info$site_name),
                                               selected = " ",
                                               prettyOptions = list(animation = 'smooth',
                                                                    plain = TRUE,
                                                                    fill = TRUE,
                                                                    icon = icon('fas fa-check'))
                                               )}
                  }
                 })
  
  
  output$map <- renderLeaflet({
    leaflet(wwtp_info) %>% 
      addTiles() %>% 
      setView(lng = -118, lat = 34, zoom = 7) %>% 
      addProviderTiles("Esri.WorldImagery")
    })
  
    
  observe({
    leafletProxy("map", data = map_reactive()) %>% 
      clearMarkers() %>% 
      addAwesomeMarkers(lng = ~ longitude_decimal_degrees,
                       lat = ~ latitude_decimal_degrees,
                       popup = ~ paste0(site_name))
    })
  

  ### WIDGET 2
  location_reactive <- reactive({
    pfa_data_final %>% 
      filter(wwtp == input$select_location)
    })
  
  
  date_reactive <- reactive({
    location_reactive %>% 
      filter(date == input$select_date)
    })
  
  
  observeEvent(input$select_location, {
    updateSelectizeInput(session, input = "select_date",
                         choices = pfa_data_final[pfa_data_final$wwtp %in% input$select_location, 
                                                  "samp_date", 
                                                  drop = TRUE])
                  })

  
  plot_data <- reactive({
    pfa_data_final %>% 
    filter(wwtp == input$select_location,
           samp_date == input$select_date)
    })
 
 
output$pfa_plot <- renderPlotly({
    ggplotly(
      ggplot(data = plot_data(), 
             aes(reorder(x = parameter, -mean_value), y = mean_value, fill = field_pt_name)) +
      geom_bar(stat = 'identity', position = position_dodge2(preserve = "single"), width = 0.5,
               aes(text = paste("parameter:", parameter, "\nconcentration:", mean_value, 'ng/L', 
                                "\nsampling location:", field_pt_name, sep = " "))) +
      guides(fill = guide_legend(title = 'sample location')) +
      scale_fill_manual(values = c('slategrey', 'steelblue1')) +
      labs(x = "PFA",
           y = "concentration (ng/L)") +
      theme_minimal(),
      tooltip = 'text')
    })
  
  
  ### WIDGET 3
  location_reactive_2 <- reactive({
    shiny_data_final %>% 
      filter(wwtp == input$select_location_2)
    })
  
  
  date_reactive_2 <- reactive({
    location_reactive_2 %>% 
      filter(date == input$select_date_2)
    })
  
  
  observeEvent(input$select_location_2, {
               updateSelectizeInput(session, input = "select_date_2",
                                     choices = shiny_data_final[shiny_data_final$wwtp %in% input$select_location_2,
                                                                "samp_date", drop = TRUE])
                 })
  
  
  plot_data_2 <- reactive({    
    shiny_data_final %>% 
      filter(wwtp == input$select_location_2,
             samp_date == input$select_date_2) %>% 
      na.omit()
    })
  
  
  output$pfa_difference <- renderPlotly({
    ggplotly(
      ggplot(data = plot_data_2(), 
             aes(x = reorder(parameter, -difference), y = difference), width = 0.5) +
      geom_bar(stat = 'identity', width = 0.5,
               aes(text = paste("parameter:", parameter, "\nconcentration difference:",
                                difference, "ng/L", sep = " "))) +
      labs(x = "PFA",
           y = "Concentration difference (ng/L)") +
      theme_minimal(),
      tooltip = 'text')
    }) 
  
  
} # end server


shinyApp(ui = ui, server = server)