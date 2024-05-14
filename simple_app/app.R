library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(plotly)
library(shinythemes)

# Sample global data (you can replace it with your own dataset)
cod_data <- read.csv('./cause_of_deaths.csv')
column_names=gsub(pattern= "\\W+",replacement=' ',x=colnames(cod_data))
colnames(cod_data)[1]='Country'

# Define UI
ui <- fluidPage(theme=shinytheme('cerulean'),
  navbarPage(title='Global Deaths',
             # code for the first page displaying world colormap
             ## has a selector for year and cause of death
             tabPanel("Global Map", 
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("year_global", "Year:", min=1990,max=2019,value=1990,step=1,sep=''),
                          selectInput("cause_global","Cause:",column_names[4:34]),
                          collapsible=TRUE
                        ),
                        mainPanel(
                          plotlyOutput("plot1")
                        )
                      )
             ),
             # code for the plot in second tab displaying line graphs
             ## choose cause and able to select multiple countries
             tabPanel("Line Graphs",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("cause","Cause:",column_names[4:34]),
                          selectInput("country","Country:",choices=unique(cod_data$Country),selected = "Malaysia",multiple=TRUE),
                          
                        ),
                        mainPanel(
                          plotOutput("lineplot")
                        )
                      )),
             # code for the third page to display predictions
             ## choose one country and cause to show predicitons for 2020-2024
              tabPanel("Predictions",
                               sidebarLayout(
                                 sidebarPanel(
                                   selectInput("cause_pred","Cause:", column_names[6:36]),
                                   selectInput("country_pred","Country:",choices=unique(cod_data$Country),selected="Malaysia")
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
    a<- input$cause_global
    # filter data by chosen year
    md1<- cod_data %>%
      filter(Year == input$year_global)
    # plot using plotly world map
    p <- plot_ly(md1,type='choropleth',
                 locations=md1$Code,
                 z=~get(a),
                 text=md1$Country) %>%
      colorbar(title = 'Value') %>%
      layout(title = paste(a,"Deaths in the World in", input$year_global))
    
    print(p)
    
  })
  
  # Page 2: Line Graphs
  output$lineplot <- renderPlot({
    # use reactive for live updates based on cause input and country input on this page
    lineplotdata<- reactive({
      data <- cod_data %>% 
      filter(Country %in% input$country) %>%
      select(Year, Country, input$cause)
      return(data)
             
             })
    # plot line graphs of each country
    q<-ggplot(lineplotdata(), aes(x = Year, y = get(input$cause),colour=COUNTRY)) +
      geom_line() +
      labs(x = "Year", y = "Count", title = input$cause) + theme_light()
    q
  })
  
  # Page 2: Line Graphs
  output$line2plot <- renderPlot({
    
    # function to generate predictions of data from selected country and cause
    prediction <- reactive({
      # filter relevant data
      data <- cod_data %>% 
        filter(Country %in% input$country_pred)
      
      # add validate to ensure there is data to make predictions on
      validate(
        need(nrow(data) > 1,"Please pick another country")
      )
      # Get selected count variable
      poisson_model <- glm(get(input$cause_pred) ~ Year, data = data, family="poisson")
      # Define future years for prediction
      future_years <- seq(2020, 2024, by = 1)
      # Create a data frame for future years
      future_df <- data.frame(Year = future_years)
      # Make predictions for future years
      predictions <- predict(poisson_model, newdata = future_df, type = "response")
      # Return predictions
      return(data.frame(Year = future_years, predictions = predictions))
    })
    
    
    
    
    # use ggplot to plot predictions
    ggplot(prediction(), aes(x = Year, y = predictions)) +
      geom_line() +
      labs(x = "Year", y = "Count", title = paste("Predictions of", input$cause_pred,"in", input$country_pred)) + theme_bw()
  })
}

# Run the application
shinyApp(ui = ui, server = server)


