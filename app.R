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
                    column(4,
                           selectInput('doctor_name',
                                       'Select user', 
                                       choices = unique(coders$physician_name),
                                       selected = unique(coders$physician_name[1]))),
                    column(4,
                           renderLeaflet('map')),
                    column(4,
                           selectInput('death_cert',
                                       'Select Death certificate info',
                                       choices = unique(coders$)))# HERE
                  
                )
            )
        ),
        tabItem(
            tabName = 'reviewers',
            fluidPage(
                fluidRow(
                    
                )
            )
        )
    )
)

# UI
ui <- dashboardPage(header, sidebar, body, skin="blue")

# Server
server <- function(input, output) {
    
  
}

shinyApp(ui, server)