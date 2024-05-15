# Shiny Dashboard for Visualising Death

This project is a Shiny dashboard built using R. It provides interactive visualizations and some prediction capability.

Link to deploy: https://jojoroy.shinyapps.io/death_dashboard_app/

## Introduction 
This dashboard is a dashbaord with three tabs, the first tab displaying the deaths around the world using a colour map to show various levels. The second is produces line graphs to see year on year trends for a number of countries you can select. The third tab allows you to pick a country and cause of death and uses a poisson regression model to produce predictions for 2020-2024.

## Data
this dataset was obtained from Kaggle who made this dataset from data from the world bank. more deatils can be found at https://www.kaggle.com/datasets/iamsouravbanerjee/cause-of-deaths-around-the-world


## Getting Started

### Prerequisites

Make sure you have R and RStudio installed on your machine. Make sure you have R and RStudio installed on your machine. This work was done on R version 4.3.1 but a lot of packages used are under 4.3.3 so it is worth ensuring your r is fully updated.

### Notes about shiny
https://rstudio.github.io/shinydashboard/get_started.html is a useful resource if you are very new to shiny to get used to reactive and the structure of how to make an app.R file.
https://engineering-shiny.org/successful-shiny-app.html is a more advanced resource and is helpful on working on the finer details.

### Notes about plotting world maps
We have opted to use the plotly library as it allows us to plot with ISO codes of countries. Other alternatives include using geom_polygon() in ggplot2 but that requires coordinates of world polygon shapes.

### Installation

1. **Clone the repository:**

```bash
   git clone https://github.com/your_username/shiny-dashboard.git
```

Open the project in RStudio.

Install required packages:

install.packages(c("shiny", "shinydashboard", "ggplot2", "dplyr")) should help install necessary packages or yuo can run the file install.R, if there are further dependencies, this code should allow the dependecies to be downloaded.
Usage
Run the app.R file in RStudio. The dashboard should open in your default web browser.



shiny::runApp("app.R")
Features
Interactive Visualizations: Explore data using interactive plots.
Data Analysis: Perform analysis on the dataset provided.

File Structure
```bash
Copy code
shiny-dashboard/
│
├── app.R             # Main Shiny application file.
│
├── data/             # Folder containing datasets used in the dashboard.
│   ├── dataset.csv
│   └── ...
│
└── www/              # Folder for storing static files like images or CSS stylesheets.
    ├── logo.png
    └── ...
```
Contributing
Contributions are welcome! If you'd like to contribute to this project, please follow these steps:

Fork the repository.
Create your feature branch: git checkout -b feature/my-feature.
Commit your changes: git commit -am 'Add some feature'.
Push to the branch: git push origin feature/my-feature.
Submit a pull request.



License
This project is licensed under the MIT License - see the LICENSE file for details.

arduino
Copy code

This Markdown file should be ready to use in your project!





