# Shiny Dashboard for Visualising Death

This project is a Shiny dashboard built using R. It provides interactive visualizations and some prediction capability.

Link to deploy: https://jojoroy.shinyapps.io/death_dashboard_app/

## Introduction 
This dashboard is a dashbaord with three tabs, the first tab displaying the deaths around the world using a colour map to show various levels. The second is produces line graphs to see year on year trends for a number of countries you can select. The third tab allows you to pick a country and cause of death and uses a poisson regression model to produce predictions for 2020-2024.

## Data
This dataset was obtained from Kaggle who made this dataset from data from the World Bank. More deatils can be found at https://www.kaggle.com/datasets/iamsouravbanerjee/cause-of-deaths-around-the-world


## Getting Started

### Prerequisites

Make sure you have R and RStudio installed on your machine. Make sure you have R and RStudio installed on your machine. This work was done on R version 4.3.1 but a lot of packages used are under 4.3.3 so it is worth ensuring your R is fully updated to the current updated version.

### Notes about shiny
https://rstudio.github.io/shinydashboard/get_started.html is a useful resource if you are very new to shiny to get used to reactive and the structure of how to make an app.R file.
https://engineering-shiny.org/successful-shiny-app.html is a more advanced resource and is helpful on working on the finer details.

### Notes about plotting world maps
We have opted to use the plotly library as it allows us to plot with ISO codes of countries. Other alternatives include using geom_polygon() in ggplot2 but that requires coordinates of world polygon shapes.

### Installation

1. Clone the repository:

```bash
   git clone https://github.com/your_username/shiny-dashboard.git
```

2. Open the project in RStudio.

3. Install required packages:

install.packages(c("shiny", "shinydashboard", "ggplot2", "dplyr")) should help install necessary packages or yuo can run the file install.R, if there are further dependencies, this code should allow the dependecies to be downloaded.

4. Usage
Run the app.R file in RStudio. The dashboard should open in your default web browser.
shiny::runApp("app.R")

###Features
Interactive Visualizations: Explore data using interactive plots in three different tabs
Predictions: Perform predictions using Poisson regression on the cause of death of your choice for a particular country.

File Structure
```bash

Shiny-Dashboard-Visualising-Death/
│
├── simple_app/             # Main Shiny application file.
│   ├── cause_of_deaths.csv
│   └── app.R
│
├── README.md           
│
└── install.R   # Code to install packages
```

### Publishing
This dashboard was pulbished on the link at the top of the page using shinyapps.io. https://docs.posit.co/shinyapps.io/?_gl=1*4j3qng*_ga*MjA4NDcxMjk0LjE3MTU2OTI4MDk.*_ga_HXP006LBGY*MTcxNTc2NTU3MC4xLjEuMTcxNTc2NTU4MS4wLjAuMA.. contains some tips on how to puclish the dashbaord yourself. You do not need to publish, running the app.R in Rstudio or going to my website allows you to look at the visualisations but should you want to publish a modified version, the guide is here. More packages you need for publishing include 'rsconnect'.

## Contributing
Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

Fork the repository.
Create your feature branch: git checkout -b feature/my-feature.
Commit your changes: git commit -am 'Add some feature'.
Push to the branch: git push origin feature/my-feature.
Submit a pull request.



## License
This project is licensed under the MIT License - see the LICENSE file for details.







