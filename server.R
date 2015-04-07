library(shiny)

data <- read.csv("data/15tstcar-2014-11-13.csv")
data <- data[,c("Represented.Test.Veh.Make","Represented.Test.Veh.Model","Test.Veh.Displacement..L.","Rated.Horsepower","X..of.Cylinders.and.Rotors","Test.Category","RND_ADJ_FE")]
colnames(data) <- c("Made","Model","Displacement","Horsepower","Cylinders","TestType","MPG")

shinyServer(function(input, output) {
  
  minHP <- reactive({input$horsepower[1]})
  maxHP <- reactive({input$horsepower[2]})

  minDP <- reactive({input$displacement[1]})
  maxDP <- reactive({input$displacement[2]})
  
  minCY <- reactive({input$cylinder[1]})
  maxCY <- reactive({input$cylinder[2]})
  
  
  
  reactiveData <- reactive({subset(data, Horsepower > minHP() & Horsepower < maxHP() & Displacement > minDP() & Displacement < maxDP() & Cylinders >= minCY() & Cylinders <= maxCY()  )})
  
  output$cars <- renderDataTable(
    reactiveData()
  , options = list(orderable = TRUE))
    
  output$summary <- renderPrint({
    dataset <- reactiveData()
    summary(dataset)
  })
  
})