library(shiny)
library(rCharts)

shinyUI(
  pageWithSidebar(
  headerPanel("2015 Model Car Mileage Per Gallon Explorer"),
  sidebarPanel(
    sliderInput("displacement", 
                "Displacement:",
                step = 0.1,
                min = 0, 
                max = 12, 
                value = c(0, 12)),
    sliderInput("horsepower", 
                "Horse Power:", 
                min = 0, 
                max = 1200, 
                value = c(0, 1200))
  ),
  mainPanel(
    tabsetPanel(
      tabPanel('data',
               verbatimTextOutput("summary"),
               dataTableOutput("cars")
               
               )
    )
  )
))