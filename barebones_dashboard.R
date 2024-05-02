library(RColorBrewer)
library(ggiraph)
library(shinydashboard)
library(shiny)
library(dplyr)
library(ggplot2)

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sliderInput("slider", "Number of observations:", 1991,2001,10),
    selectInput("variable","Variable:",c("Meningitis","Malaria","Tuberculosis"))
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 250,width=500)))
  )
)


server <- function(input, output) {
  
  
  output$plot1 <- renderPlot({
    
    md1<- merged_data %>%
      filter(Year == input$slider )
    a<-input$variable
    ggplot() + 
      
      # geom_map() function takes world coordinates as input  
      # to plot world map color parameter determines the  
      # color of borders in map fill parameter determines  
      # the color of fill in map size determines the thickness 
      # of border in map 
      geom_map( 
        data = md1, map = world_coordinates, 
        aes(x=long, y=lat, map_id = region, fill = get(a)) ,color = "white", size = 0.2 
      )+ 
      scale_fill_gradientn(colours = brewer.pal(10, "RdBu"), na.value = 'white')
  })
}

shinyApp(ui, server)