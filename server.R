library(shiny)

data <- read.csv("data/15tstcar-2014-11-13.csv")
data <- data[,c("Represented.Test.Veh.Make","Represented.Test.Veh.Model","Test.Veh.Displacement..L.","Rated.Horsepower","Test.Category","RND_ADJ_FE")]
colnames(data) <- c("Made","Model","Displacement","Horsepower","TestType","MPG")

shinyServer(function(input, output) {
  
  minHP <- reactive({input$horsepower[1]})
  maxHP <- reactive({input$horsepower[2]})

  minDP <- reactive({input$displacement[1]})
  maxDP <- reactive({input$displacement[2]})
  
  
  
  reactiveData <- reactive({subset(data, Horsepower > minHP() & Horsepower < maxHP() & Displacement > minDP() & Displacement < maxDP() )})
  
  output$cars <- renderDataTable(
    reactiveData()
  , options = list(orderable = TRUE))
    
  output$summary <- renderPrint({
    dataset <- reactiveData()
    summary(dataset)
  })
  
})