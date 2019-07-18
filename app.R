source('global.R')

# create header and define sidebar items
header <- dashboardHeader(title="Databrew app")
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      text="Coders",
      tabName="coders",
      icon=icon("eye")),
    menuItem(
      text = 'Reviewers',
      tabName = 'reviewers',
      icon = icon("cog", lib = "glyphicon"))
  )
)

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  tabItems(
    tabItem(
      tabName="coders",
      fluidPage(
        fluidRow(
          box( width = 12, 
               title = '', 
               status  = 'primary', 
               solidHeader = T,
          column(4,
                 selectInput('doctor_name',
                             'Select user', 
                             choices = unique(coders$physician_name_1),
                             selected =  unique(coders$physician_name_1)[1])),
          column(4,
                 leafletOutput('map')),
          column(4,
                 DT::dataTableOutput('death_cert_table')))
          
        ),
        fluidRow(
          box( width = 4, 
               title = 'Primary symptoms', 
               status  = 'primary', 
               solidHeader = T,
          column(6,
                 textOutput('symptoms'))),
          box( width = 4, 
               title = 'Narrative', 
               status  = 'primary', 
               solidHeader = T,
          column(4,
                 textOutput('narrative'))),
          box( width = 4, 
               title = 'Physician comments', 
               status  = 'primary', 
               solidHeader = T,
          column(4,
                 textOutput('comments')))# HERE
          
        ),
        fluidRow(
          box(width = 12,
              title = 'Demographics & Cause of death',
              status = 'primary',
              solidHeader = T,
          column(4,
                 DT::dataTableOutput('demo_table')),
         
          column(2,
                 selectInput('causa_directa',
                             'Causa Directa', 
                             choices = unique(coders$icd_directa),
                             selected = unique(coders$icd_directa)[2])),
          column(2,
                
                 selectInput('causa_intermedia',
                             'Causa Intermedia', 
                             choices = unique(coders$icd_intermedia),
                             selected = unique(coders$icd_intermedia)[5])),
          column(2,
                 selectInput('causa_subjacente',
                             'Causa Subjacente', 
                             choices = unique(coders$icd_subjacente),
                             selected = unique(coders$icd_subjacente)[3])))
        )
      )
    ),
    tabItem(
      tabName = 'reviewers',
      fluidPage(
        fluidRow(
          box( width = 12, 
               title = '', 
               status  = 'primary', 
               solidHeader = T,
               column(4,
                      selectInput('doctor_name_2',
                                  'Select user', 
                                  choices = unique(coders$physician_name_2),
                                  selected =  unique(coders$physician_name_2)[1])),
               column(4,
                      leafletOutput('map_2')),
               column(4,
                      DT::dataTableOutput('death_cert_table_2')))
          
        ),
        fluidRow(
          box( width = 4, 
               title = 'Primary symptoms', 
               status  = 'primary', 
               solidHeader = T,
               column(6,
                      textOutput('symptoms_2'))),
          box( width = 4, 
               title = 'Narrative', 
               status  = 'primary', 
               solidHeader = T,
               column(4,
                      textOutput('narrative_2'))),
          box( width = 4, 
               title = 'Physician comments', 
               status  = 'primary', 
               solidHeader = T,
               column(4,
                      textOutput('comments_2')))# HERE
          
        ),
        fluidRow(
          box(width = 12,
              title = 'Demographics & Cause of death',
              status = 'primary',
              solidHeader = T,
              column(4,
                     DT::dataTableOutput('demo_table_2')),
              
              column(2,
                     selectInput('causa_directa',
                                 'Causa Directa', 
                                 choices = unique(coders$icd_directa),
                                 selected = unique(coders$icd_directa)[2])),
              column(2,
                     
                     selectInput('causa_intermedia_2',
                                 'Causa Intermedia', 
                                 choices = unique(coders$icd_intermedia),
                                 selected = unique(coders$icd_intermedia)[5])),
              column(2,
                     selectInput('causa_subjacente_2',
                                 'Causa Subjacente', 
                                 choices = unique(coders$icd_subjacente),
                                 selected = unique(coders$icd_subjacente)[3])))
        )
      )
    )
  )
)

# UI
ui <- dashboardPage(header, sidebar, body, skin="blue")

# Server
server <- function(input, output) {
  
  # create a reative data set that is subsetted by
  
  # create a uioutput for death cert details
  doc_data <- reactive({
    
    # get doctor name
    doc_name <- input$doctor_name
    
    # subet data
    x <- coders[coders$physician_name_1 == doc_name,]
    
    # change names of x
    names(x) <- c('Physician name','Reviewing physician', 'Name', 'Gender', 'ID', 'Date of birth', 'Date of death', 'Place of death',
                  'Lat', 'Lon', 'Age of death', 'Season of death', 'Symptoms', 'Description',
                  'Causa imediata', 'Primeira causa', 'Comments', 'Causa directa', 'Causa intermedia', 'Cause subjacente')
    
    return(x)
    
  })
  
  # create a table output that shows the demographic details of deceased
  output$demo_table <- DT::renderDataTable({
    # get doc data from reactive object
    x <- doc_data()
    
    # keep only name, id, gender, dob, dod, aod, and season
    x <- x[, c('Name', 'Gender','ID', 'Date of birth', 'Date of death', 'Place of death', 'Age of death', 'Season of death')]
    
    # make data long
    x <- as.data.frame(t(x))
    
    # replace colnames with blank
    names(x) <- ''
    
    datatable(x, rownames = TRUE, colnames = '')
    
    
  })
  
  # create a table output that shows the demographic details of deceased
  output$demo_table <- DT::renderDataTable({
    # get doc data from reactive object
    x <- doc_data()
    
    # keep only name, id, gender, dob, dod, aod, and season
    x <- x[, c('Name', 'Gender','ID', 'Date of birth', 'Date of death', 'Place of death', 'Age of death', 'Season of death')]
    
    # make data long
    x <- as.data.frame(t(x))
    
    # replace colnames with blank
    names(x) <- ''
    
    datatable(x, rownames = TRUE, colnames = '')
    
    
  })
  
  # create a table output that shows the demographic details of deceased
  output$death_cert_table <- DT::renderDataTable({
    # get doc data from reactive object
    x <- doc_data()
    
    # keep only name, id, gender, dob, dod, aod, and season
    x <- x[, c( 'Causa imediata', 'Primeira causa')]
    
    # make data long
    x <- as.data.frame(t(x))
    
    # replace colnames with blank
    names(x) <- ''
    
    datatable(x, rownames = TRUE, colnames = '')
    
    
  })
  
  # create a table output that shows the demographic details of deceased
  output$narrative <-renderText({
    # get doc data from reactive object
    x <- doc_data()
    
    # keep only name, id, gender, dob, dod, aod, and season
    x <- x[, c( 'Description')]
    
    paste0(as.character(x))
    
  })
  
  
  # create a table output that shows the demographic details of deceased
  output$comments <- renderText({
    # get doc data from reactive object
    x <- doc_data()
    
    # keep only name, id, gender, dob, dod, aod, and season
    x <- x[, c( 'Comments')]
    
    paste0(as.character(x))
    
  })
  
  
  # create a table output that shows the demographic details of deceased
  output$symptoms <- renderText({
    # get doc data from reactive object
    x <- doc_data()
    
    # keep only name, id, gender, dob, dod, aod, and season
    x <- x[, c( 'Symptoms')]
    
    paste0(as.character(x))
    
  })
  
  
  # create a map output for leaflet
  output$map <- renderLeaflet({
    # get doc data from reactive object
    x <- doc_data()
    
    # keep only name, id, gender, dob, dod, aod, and season
    x <- x[, c('Name', 'Gender','ID', 'Date of birth', 'Date of death', 'Place of death', 'Age of death', 'Season of death', 'Lat', 'Lon')]
    
    leaflet(data = x) %>% addTiles() %>%
      setView(x$Lat, x$Lon, zoom = 04) %>%
      addMarkers(~Lat, ~Lon, popup = ~as.character(Name), label = ~as.character(Name))
    
  })
  
}



shinyApp(ui, server)
