library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(plotly)

# Sample global data (you can replace it with your own dataset)
data <- read.csv("https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv")

# Define UI
ui <- fluidPage(
  navbarPage("Multipage Dashboard",
             tabPanel("Global Map", 
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("slider", "Number of observations:", 1991,2001,10),
                          selectInput("variable","Variable:",c("Meningitis","Malaria","Tuberculosis")),
                          collapsible=TRUE
                        ),
                        mainPanel(
                          plotlyOutput("plot1")
                        )
                      )
             ),
             tabPanel("Line Graphs",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("variable","Variable:",c("Meningitis","Malaria","Tuberculosis")),
                          selectInput("country","Country:",choices=unique(merged_data$COUNTRY),selected = "Malaysia",multiple=TRUE),
                          
                        ),
                        mainPanel(
                          plotOutput("lineplot")
                        )
                      )),
              tabPanel("Line Graphs",
                               sidebarLayout(
                                 sidebarPanel(
                                   selectInput("var","Variable:",c("Meningitis","Malaria","Tuberculosis")),
                                   selectInput("countryp","Country:",choices=unique(merged_data$COUNTRY),selected="Malaysia",multiple=TRUE),
                                   
                                 ),
                                 mainPanel(
                                   plotOutput("line2plot")
                                 )
                               ))
  
  
))

# Define server logic
server <- function(input, output) {
  
  # Page 1: Global Map
  output$plot1 <- renderPlotly({
    a<- input$variable
    md1<- merged_data %>%
      filter(Year == input$slider)
    p<-plot_ly(md1,type='choropleth',locations=md1$CODE,z=~get(a),text=md1$Country)
    p
    
  })
  
  # Page 2: Line Graphs
  output$lineplot <- renderPlot({
    data <- merged_data %>% 
      filter(COUNTRY %in% input$country)
    ggplot(data, aes(x = Year, y = get(input$variable),colour=COUNTRY)) +
      geom_line() +
      labs(x = "Time", y = "Total Bill", title = "Total Bill over Time")
  })
  
  # Page 2: Line Graphs
  output$line2plot <- renderPlot({
    
    
    prediction <- reactive({
      data <- merged_data %>% 
        filter(COUNTRY %in% input$countryp)
      # Get selected count variable
      poisson_model <- glm(get(input$var) ~ Year, data = data,family="poisson")
      # Define future years for prediction
      future_years <- seq(2016, 2021, by = 1)
      # Create a data frame for future years
      future_df <- data.frame(Year = future_years)
      # Make predictions for future years
      predictions <- predict(poisson_model, newdata = future_df, type = "response")
      # Return predictions
      return(data.frame(Year = future_years, predictions = predictions))
    })
    
    
    
    
    
    ggplot(prediction(), aes(x = Year, y = predictions)) +
      geom_line() +
      labs(x = "Time", y = "Total Bill", title = "Total Bill over Time")
  })
}

# Run the application
shinyApp(ui = ui, server = server)


