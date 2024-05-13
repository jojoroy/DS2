library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(plotly)

# Sample global data (you can replace it with your own dataset)
data <- read.csv("https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv")

# Define UI
ui <- fluidPage(
  navbarPage(title='Global Deaths',
             tabPanel("Global Map", 
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("year_global", "Year:", min=1990,max=2019,value=1990,step=1,sep=''),
                          selectInput("cause_global","Cause:",colnames(wd)[6:36]),
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
                          selectInput("variable2","Variable:",colnames(merged_data)[6:36]),
                          selectInput("country","Country:",choices=unique(merged_data$COUNTRY),selected = "Malaysia",multiple=TRUE),
                          
                        ),
                        mainPanel(
                          plotOutput("lineplot")
                        )
                      )),
              tabPanel("Predictions",
                               sidebarLayout(
                                 sidebarPanel(
                                   selectInput("var","Variable:", colnames(merged_data)[6:36]),
                                   selectInput("countryp","Country:",choices=unique(merged_data$COUNTRY),selected="Malaysia")
                                 ),
                                 mainPanel(
                                   plotOutput("line2plot")
                                 )
                               )),
             tags$style(
               HTML("
                    .navbar {
                    background-color: #337ab7;
                    }
                    ")
             )
  
  
))

# Define server logic
server <- function(input, output) {
  
  # Page 1: Global Map
  output$plot1 <- renderPlotly({
    a<- input$cause_global
    md1<- wd %>%
      filter(Year == input$year_global)
    p<-plot_ly(md1,type='choropleth',locations=md1$Code,z=~get(a),text=md1$Country) %>%
      colorbar(title='Value') %>%
      layout(title=paste(a," Deaths in the World in", input$year_global))
    
    print(p)
    
  })
  
  # Page 2: Line Graphs
  output$lineplot <- renderPlot({
    
    lineplotdata<- reactive({
      data <- merged_data %>% 
      filter(COUNTRY %in% input$country) %>%
      select(Year, COUNTRY, input$variable2)
      return(data)
             
             })
    
    q<-ggplot(lineplotdata(), aes(x = Year, y = get(input$variable2),colour=COUNTRY)) +
      geom_line() +
      labs(x = "Year", y = "Count", title = input$variable2) + theme_bw()
    q
  })
  
  # Page 2: Line Graphs
  output$line2plot <- renderPlot({
    
    
    prediction <- reactive({
      data <- merged_data %>% 
        filter(COUNTRY %in% input$countryp)
      validate(
        need(nrow(data)>1,"Please pick another country")
      )
      # Get selected count variable
      poisson_model <- glm(get(input$var) ~ Year, data = data, family="poisson")
      # Define future years for prediction
      future_years <- seq(2020, 2024, by = 1)
      # Create a data frame for future years
      future_df <- data.frame(Year = future_years)
      # Make predictions for future years
      predictions <- predict(poisson_model, newdata = future_df, type = "response")
      # Return predictions
      return(data.frame(Year = future_years, predictions = predictions))
    })
    
    
    
    
    
    ggplot(prediction(), aes(x = Year, y = predictions)) +
      geom_line() +
      labs(x = "Year", y = "Count", title = paste("Predictions of ", input$var," in ", input$countryp))
  })
}

# Run the application
shinyApp(ui = ui, server = server)


