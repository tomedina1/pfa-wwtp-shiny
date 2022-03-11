
### PFAS TRACKER SOURCE CODE
### Contact tomedina@bren.ucsb.edu if you have any questions


### PFAS TRACKER SETUP

### Load packages
library(shiny)
library(tidyverse)
library(leaflet)
library(shinyWidgets)
library(bslib)
library(here)
library(plotly)
library(writexl)

### Read in data
pfa_data <- read_csv(here('wwtp_pfa', 'pfa.csv'))
pfa_data_final <- read_csv(here('wwtp_pfa', 'pfa_data.csv'))
shiny_data_final <- read_csv(here('wwtp_pfa', 'difference_data_pfas.csv'))

### Source data from other scripts
source('spatial_data.R')
source('pfa_info.R')

### Add a theme to the shiny app
my_theme <- bs_theme(bootswatch = "lux", "font-size-base" = "1rem")


### User Interface 
ui <- fluidPage(theme = my_theme,

                
                navbarPage('PFAS Tracker',
                           
                           
                           ### Tab 1: Information on PFAS - Includes slider and interactive data table
                           tabPanel('PFAS Information',
                                    
                                    sidebarLayout(
                                      
                                    
                                      sidebarPanel(width = 3,
                                                   
                                                   h3('Additional Info'),
                                                   
                                                   tags$div('Click below for additional detailed PFAs info from the',
                                                            tags$a(href="https://www.oecd.org/chemicalsafety/portal-perfluorinated-chemicals/", "OECD"), '.'),
                                                   
                                                   br(),
                                                   
                                                   downloadButton('pfa_add_info', 'Download Additional PFA information'),
                                                   
                                                   br(),
                                                   br(),
                                                   
                                                   p('This dataset contains additional information on PFA structures, naming conventions, regulatory status,
                                                     historical production data, chemical sources, and ecological and human effects.'),
                                                   
                                                   br(),
                                                   
                                                   tags$div('For additional information on the chemical and physical properties of PFAs and other chemicals, visit',
                                                            tags$a(href = "https://pubchem.ncbi.nlm.nih.gov/", "PubChem"), '.'),
                                                   
                                                   hr(style = "border-top: 1px solid #000000;"),
                                                   
                                                   ### interactive slider
                                                   sliderInput("mass_range",
                                                              label = h3('Select a mass range'),
                                                              min = 210,
                                                              max = 815,
                                                              value = c(210, 815),
                                                              ticks = FALSE,
                                                              sep = ""),
                                                   
                                                   p('This slider selects a range of molar masses (g/mol) to display the PFAs being studied that have 
                                                     masses in the selected range.')

                                                  ),
                                  
                                      
                                      mainPanel(
                                        
                                        br(),
                                        
                                        includeMarkdown('background.md'),
                                        
                                        ### Data Table Widget
                                        dataTableOutput("pfadt")
                                        
                                      ))),
                           
                           
                           ### Tab 2: WWTP Maps - Contains checkbox group, select all action button, and Leaflet Map Output
                           tabPanel('WWTP Map',
                                    
                                    sidebarLayout(
                                      
                                      sidebarPanel(width = 3,
                                                   
                                                   ### checkbox widget
                                                   prettyCheckboxGroup("select_site", label = h3("Select Treatment Site"),
                                                           choices = unique(wwtp_info$site_name),
                                                           plain = TRUE,
                                                           fill = TRUE,
                                                           icon = icon("fas fa-check"),
                                                           animation = 'smooth'),
                                                   
                                                   ### select all button
                                                   actionButton("selectall", label = "Select / Deselect all")
                                        
                                        ), 
                                  
                                    mainPanel(
                                      
                                      br(),
                                      
                                      includeMarkdown('map_info.md'),
                                      
                                      ### Leaflet Map Output
                                      leafletOutput("map", height = 700)
                                      
                                      ))), 
                           
                           
                           ### Tab 3: PFAS concentrations plot - contains select input widget and plotly output
                           tabPanel('PFAS Concentrations',
                                    
                                    sidebarLayout(
                                      
                                      sidebarPanel(width = 4,
                                                   
                                                   ### selectize input widgets
                                                   selectInput(
                                                     "select_location", label = h3("Select Location"),
                                                     choices = unique(pfa_data_final$wwtp)), 
                                                   
                                                   selectizeInput(
                                                     "select_date", label = h3("Select Sampling Date"),
                                                     choices = unique(pfa_data_final$samp_date)),
                                                   
                                                   hr(style = "border-top: 1px solid #000000;"),
                                                   
                                                   h3('Data Download'),
                                                   
                                                   tags$div('Click the button below to download the raw concentration data as a CSV file.'),
                                                   
                                                   ### download action button
                                                   downloadButton('pfa_data', 'Download concentration data here'),
                                                   
                                                   tags$div('This dataset contains information on the sampling site, sampling date, sampling 
                                                   location within the WWTP, the specific chemical being measured, and the measured concentrations.')
                                                   
                                                   ), 
                                      
                                      mainPanel(width = 8,
                                                
                                                br(),
                                                
                                                h3('PFAS Concentrations by Wastewater Treatment Plant'),
                                                
                                                tags$div('Each treatment site contains unique PFAS at differing concentrations. 
                                                 Select a wastewater treamtent plant and sampling date to view PFAS concentrations found in the influent and 
                                                 the effluent of the water treatment site. Hover over the bars in the plot to get the concentration values.'),
                                                
                                                tags$style(type = "text/css",
                                                           ".shiny-output-error { visibility: hidden; }",
                                                           ".shiny-output-error: before { visibility: hidden; }"),
                                                
                                                ### Plotly widget
                                                plotlyOutput("pfa_plot", height = 800)
                                                
                                                ))), 
                           
                           
                           ### Tab 4: PFAS formation plot - same as Task 3
                           tabPanel('PFAS Formation',
                                    
                                    sidebarLayout(
                                      
                                      sidebarPanel(width = 4, 
                                                   
                                                   ### selectize inputs
                                                   selectInput(
                                                     "select_location_2", label = h3("Select Location"),
                                                     choices = unique(shiny_data_final$wwtp)),
                                                   
                                                   selectizeInput(
                                                     "select_date_2", label = h3("Select Sampling Date"),
                                                     choices = unique(shiny_data_final$samp_date)),
                                                   
                                                   hr(style = "border-top: 1px solid #000000;"),
                                                   
                                                   h3('Formation Data Download'),
                                                   
                                                   tags$div('Click the button below to download the raw concentration data as a CSV file.'),
                                                   
                                                   ### download button
                                                   downloadButton('diff_data', 'Download PFAS Formation Data Here'),
                                                   
                                                   tags$div('This dataset contains information on the sampling site, sampling date, sampling location within the WWTP, 
                                                   the specific chemical being measured, the effluent and influent concentrations, and the measures concentration 
                                                            difference.')

                                      ), 
                                      
                                      mainPanel(width = 8,
                                                
                                                br(),
                                                
                                                includeMarkdown('formation_info.md'),
                                                
                                                ### plotly output
                                                plotlyOutput("pfa_difference", height = 800)
                                        
                                      ))), 
                           
                          
                           ### Tab 5 - About the Author
                           tabPanel('About',
                                    
                                    fluidRow(
                                      
                                      column(1),
                                      
                                      column(5,
                                             
                                             align = "center",
                                             
                                             br(),
                                             
                                             h3(style="text-align: left;",
                                                'About the Author'),
                                             
                                             hr(style = "border-top: 1px solid #000000;"),
                                             
                                             p(style="text-align: left;",
                                             'Taylor Medina is a Masters of Science in Environmental Science and Management (MESM) student at the Bren School of 
                                               Environmental Science and Management at the University of California Santa Barbara. He is focusing on Pollution Prevention 
                                               and Remediation and is interested in the prevalence of emerging pollutants and their effects on the environment as well as 
                                               applying data science to a variety of environmental applications.'),
                                             
                                             ### Links
                                             actionButton(inputId = 'git',
                                                          label = 'Github',
                                                          icon = icon("fa-brands fa-github"),
                                                          onclick = "window.open('https://github.com/tomedinabren')"),
                                             
                                             
                                             actionButton(inputId = 'linkedin',
                                                          label = 'LinkedIn',
                                                          icon = icon("fa-brands fa-linkedin"),
                                                          onclick = "window.open('https://www.linkedin.com/in/taylor-medina-03b548225/')"),
                                             
                                             
                                             actionButton(inputId = 'email',
                                                          label = 'Email',
                                                          icon = icon("fa-solid fa-envelope"),
                                                          href = "mailto:tomedina@bren.ucsb.edu"),
                
                                             br(),
                                             
                                             br(),
                                             
                                             HTML('<img src="bren.jpg" style="height: 120px; width:650px;"/>'),

                                             ),
                                      
                                      column(1),
                                      
                                      column(5,
                                             
                                             br(),
                                             
                                             br(),
                                             
                                             HTML('<img src="taylor.jpg" alt="Taylor Medina" style="height: 450px; width:310px;"/>'),
                                             
                                            ))))) 



server <- function(input, output, session){
  
  ### Tab 1 
  
  ### Download Button
  output$pfa_add_info <- downloadHandler(
    filename = function(){
      
      'pfa_add_info.xlsx'
      
    },
    
    content = function(file){
      
      write_xlsx('pfa_add_info.xlsx')
      
      })
  
  
  ### Data Table
  output$pfadt <- renderDataTable({
    dt <- parameters[parameters$molar_mass >= input$mass_range[1] & parameters$molar_mass <= input$mass_range[2], ]},
  options = list(
    pageLength = 35,
    autoWidth = TRUE,
    info = FALSE,
    dom = 'ft',
    columns = list(
      list(title = 'PFA'),
      list(title = 'Chemical Name'),
      list(title = 'Molar Mass (g/mol)'),
      list(title = 'Chemical Formula'))))
  
  
  ### Tab 2 
  
  ### Checkbox input
  map_reactive <- reactive({
    wwtp_info %>% 
      filter(site_name %in% input$select_site)})
  
  
  ### Select All Button
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
                                                                    icon = icon('fas fa-check')))}
                 
                   else {
                     
                     updatePrettyCheckboxGroup(session = session, 
                                               inputId = "select_site",
                                               choices = unique(wwtp_info$site_name),
                                               selected = " ",
                                               prettyOptions = list(animation = 'smooth',
                                                                    plain = TRUE,
                                                                    fill = TRUE,
                                                                    icon = icon('fas fa-check')))}
                 }
                 })
  
  
  ### Leaflet Map
  output$map <- renderLeaflet({
    leaflet(wwtp_info) %>% 
      addTiles() %>% 
      setView(lng = -118, lat = 34, zoom = 7) %>% 
      addProviderTiles("Esri.WorldImagery")})
  
  observe({
    leafletProxy("map", data = map_reactive()) %>% 
      clearMarkers() %>% 
      addAwesomeMarkers(lng = ~ longitude_decimal_degrees,
                       lat = ~ latitude_decimal_degrees,
                       popup = ~ paste(site_name, "<br>",
                                       "Design Flow:", flow, 'MGD', sep = " "))})
  

  ### Tab 3
  
  ### Download Button
  output$pfa_data <- downloadHandler(
    filename = function(){
      
      'pfa_data.csv'
      
      },
    
    content = function(file){
      
      write_csv('pfa_data.csv')
      
    })
  
  
  ### Selectize Input for Location
  location_reactive <- reactive({
    pfa_data_final %>% 
      filter(wwtp == input$select_location)})
  
  
  ### Selectize Input for Date
  date_reactive <- reactive({
    location_reactive %>% 
      filter(date == input$select_date)})
  
  
  ### Update Selectize Input for Date based off of location 
  observeEvent(input$select_location, {
    updateSelectizeInput(session, input = "select_date", 
                         choices = pfa_data_final[pfa_data_final$wwtp %in% input$select_location, 
                                                  "samp_date", drop = TRUE])})

  ### Data for ggplotly output
  plot_data <- reactive({
    pfa_data_final %>% 
    filter(wwtp == input$select_location,
           samp_date == input$select_date)})
  
  
  ### Plotly Ouput
  output$pfa_plot <- renderPlotly({
    ggplotly(
      ggplot(data = plot_data(), 
             aes(reorder(x = parameter, -mean_value), y = mean_value, fill = field_pt_name)) +
        geom_bar(stat = 'identity', position = position_dodge2(preserve = "single"), width = 0.5,
               aes(text = paste("parameter:", parameter, "\nconcentration:", mean_value, 'ng/L', 
                                "\nsampling location:", field_pt_name, sep = " "))) +
        guides(fill = guide_legend(title = 'sample location')) +
        scale_fill_manual(values = c('steelblue1', 'slategrey'), drop = FALSE) +
        labs(x = "PFA",
             y = "concentration (ng/L)") +
        theme_minimal(),
      tooltip = 'text')})
  
  
  ### Tab 4
  
  ### Data Download
  output$diff_data <- downloadHandler(
    filename = function(){
      
      'difference_data_pfas.csv'
      
    },
  
    content = function(file){
      
      write_csv('diff_data.csv')
    
      })

  ### Selectize Input for Location
  location_reactive_2 <- reactive({
    shiny_data_final %>% 
      filter(wwtp == input$select_location_2)})
  
  ### Selectize Input for Date 
  date_reactive_2 <- reactive({
    location_reactive_2 %>% 
      filter(date == input$select_date_2)})
  
  ### Update Selectize Input for Date based off of location
  observeEvent(input$select_location_2, {
               updateSelectizeInput(session, input = "select_date_2",
                                    choices = shiny_data_final[shiny_data_final$wwtp %in% input$select_location_2,
                                                               "samp_date", drop = TRUE])})
  
  ### Data for ggplotly output 
  plot_data_2 <- reactive({    
    shiny_data_final %>% 
      filter(wwtp == input$select_location_2,
             samp_date == input$select_date_2) %>% 
      na.omit()})
  
  ### Plotly Ouput
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
      tooltip = 'text')}) 
  
  
} # end server


shinyApp(ui = ui, server = server)