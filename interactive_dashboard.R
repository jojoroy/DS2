library(RColorBrewer)
library(ggiraph)
library(shinydashboard)
library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
    sliderInput("slider", "Number of observations:", 1991,2017,27),
    selectInput("variable","Variable:",colnames(merged_data)[6:36])
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidPage(
      plotlyOutput("plot1", height = 250,width=500))
  )
)


server <- function(input, output) {
  
  
  output$plot1 <- renderPlotly({
    a<- input$variable
    md1<- merged_data %>%
      filter(Year == input$slider)
    p<-plot_ly(md1,type='choropleth',locations=md1$CODE,z=~get(a),text=md1$Country)
    p
    
  })
}

shinyApp(ui, server)



