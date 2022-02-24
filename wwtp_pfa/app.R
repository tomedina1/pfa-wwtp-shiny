
library(shiny)
library(tidyverse)
library(leaflet)
library(shinyWidgets)
library(bslib)
library(plotly)
library(writexl)


source('data_wrangling.R')
source('spatial_data.R')
source('pfa_info.R')


my_theme <- bs_theme(bootswatch = "lux")


ui <- fluidPage(theme = my_theme,

                
                navbarPage('PFAS Tracker',
                           
                           
                           tabPanel('PFAS',
                                    
                                   
                                    sidebarLayout(
                                      
                                      sidebarPanel(width = 3,
                                                   
                                                   h3('Additional Info'),
                                                   
                                                   tags$div('Click below for additional detailed PFAs info from the',
                                                            tags$a(href="https://www.oecd.org/chemicalsafety/portal-perfluorinated-chemicals/", "OECD"), '.'),
                                                   
                                                   br(),
                                                   
                                                   downloadButton('dl', 'Download Additional PFA information'),
                                                   
                                                   br(),
                                                   br(),
                                                   
                                                   p('This dataset contains additional information on PFA structures, naming conventions, regulatory status,
                                                     historical production data, chemical sources, and ecological and human effects.'),
                                                   
                                                   br(),
                                                   
                                                   tags$div('For additional information on the chemical and physical properties of PFAs and other chemicals, visit',
                                                            tags$a(href = "https://pubchem.ncbi.nlm.nih.gov/", "PubChem"), '.'),

                                                   
                                                   hr(style = "border-top: 1px solid #000000;"),
                                                
                                                   sliderInput("mass_range",
                                                              label = h3('Select a mass range'),
                                                              min = 210,
                                                              max = 815,
                                                              value = c(390, 610),
                                                              ticks = FALSE,
                                                              sep = ""),
                                                   
                                                   p('This slider selects a range of molar masses (g/mol) to display the PFAs being studied that have masses in the selected range.')

                                                  
                                                  ),
                                  
                                      
                                      mainPanel(
                                        
                                        br(),
                                        
                                        includeMarkdown('background.md'),
                                        
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
                                      
                                      br(),
                                      
                                      includeMarkdown('map_info.md'),
                                      
                                      leafletOutput("map", height = 700)
                                      
                                      ) # end mainPanel 
                                    
                                    ) # end sidebarLayout
                                    
                                    ), # end tabPanel
                           
                           
                           tabPanel('PFAS Concentrations',
                                    
                                    sidebarLayout(
                                      
                                      sidebarPanel(width = 3,
                                        
                                        selectInput(
                                          "select_location", label = h3("Select Location"),
                                          choices = unique(pfa_data_final$wwtp)), 
                                        
                                        selectizeInput(
                                          "select_date", label = h3("Select Sampling Date"),
                                          choices = unique(pfa_data_final$samp_date)),
                                        
                                        hr(style = "border-top: 1px solid #000000;"),
                                        
                                        h3('Data Download'),
                                        
                                        tags$div('Click the button below to download the raw concentration data as a CSV file.'),
                                        
                                        downloadButton('conc_data', 'Download concentration data here'),
                                        
                                        tags$div('This dataset contains information on the sampling site, sampling date, sampling location within the WWTP, the specific chemical
                                                 being measured, and the measured concentrations.')
                            
                                      ), # end sidebarPanel
                                      
                                      mainPanel(
                                        
                                        br(),
                                        
                                        h3('PFAS Concentrations by Wastewater Treatment Plant'),
                                        
                                        tags$div('Each treatment site contains unique PFAS at differing concentrations. 
                                                 Select a wastewater treamtent plant and sampling date to view PFAS concentrations found in the influent and the effluent of the 
                                                 water treatment site. Hover over the bars in the plot to get the concentration values.'),
                                        
                                        tags$style(type = "text/css",
                                                   ".shiny-output-error { visibility: hidden; }",
                                                   ".shiny-output-error: before { visibility: hidden; }"),
                                        
                                        plotlyOutput("pfa_plot", height = 800)
                                        
                                      ) # end mainPanel
                                    
                                      ) # end sidebarLayout
                                    
                                    ), # end tabPanel
                           
                           
                           tabPanel('PFAS Formation',
                                    
                                    sidebarLayout(
                                      
                                      sidebarPanel(width = 3, 
                                        
                                        selectInput(
                                          "select_location_2", label = h3("Select Location"),
                                          choices = unique(shiny_data_final$wwtp)),
                                        
                                        selectizeInput(
                                          "select_date_2", label = h3("Select Sampling Date"),
                                          choices = unique(shiny_data_final$samp_date)),
                                        
                                        hr(style = "border-top: 1px solid #000000;"),
                                        
                                        h3('Formation Data Download'),
                                        
                                        tags$div('Click the button below to download the raw concentration data as a CSV file.'),
                                        
                                        downloadButton('diff_data', 'Download WWTP PFAS Formation Data Here'),
                                        
                                        tags$div('This dataset contains information on the sampling site, sampling date, sampling location within the WWTP, the specific chemical
                                                 being measured, the effluent and influent concentrations, and the measures concentration difference.')
                                        
                                      ), # end sidebarPanel
                                      
                                      
                                      mainPanel(
                                        
                                        plotlyOutput("pfa_difference", height = 800)
                                        
                                      ) # end mainPanel
                                      
                                    ) # end sidebarLayout
                                    
                           ), # end tabPanel
                           
                           
                           tabPanel('References'),
                           
                           
                           tabPanel('Contact')
                           
                           
                           ) # end navbarPage

                ) # end ui


server <- function(input, output, session){
  
  ### BACKGROUND
  output$dl <- downloadHandler(
    
    filename = function(){
      'pfa_add_info.xlsx'
    },
    
    content = function(file){
      write_xlsx(
        'pfa_add_info.xlsx'
      )
    }
  )
  
  
  output$pfadt <- renderDataTable({
    dt <- parameters[parameters$molar_mass >= input$mass_range[1] & parameters$molar_mass <= input$mass_range[2], ]},
  
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
  
  output$conc_data <- downloadHandler(
    
    filename = function(){
      'pfa_data.csv'
    },
    
    content = function(file){
      write_csv(
        'pfa_data.csv'
      )
    }
  )
  
  
  location_reactive <- reactive({
    pfa_data_final %>% 
      filter(wwtp == input$select_location)
    })
  
  
  date_reactive <- reactive({
    location_reactive %>% 
      filter(date == input$select_date)
    })
  
  
  observeEvent(input$select_location, {
    updateSelectizeInput(session, 
                         input = "select_date",
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

  output$diff_data <- downloadHandler(
  
    filename = function(){
      'difference_data_pfas.csv'
    },
  
    content = function(file){
      write_csv(
        'diff_data.csv'
      )
    }
  )


  location_reactive_2 <- reactive({
    shiny_data_final %>% 
      filter(wwtp == input$select_location_2)
    })
  
  
  date_reactive_2 <- reactive({
    location_reactive_2 %>% 
      filter(date == input$select_date_2)
    })
  
  
  observeEvent(input$select_location_2, {
               updateSelectizeInput(session, 
                                    input = "select_date_2",
                                    choices = shiny_data_final[shiny_data_final$wwtp %in% input$select_location_2,
                                                               "samp_date", 
                                                               drop = TRUE])
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