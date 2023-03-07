library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  data<-read.csv("Assignment93.csv",header = TRUE)
  data$Date <- as.Date(data$Date, "%m/%d/%Y")
  data$Moon.Phases<-as.factor(data$Moon.Phases)
  
  output$plot1 <- renderPlot({
    
    data1<-data[data$Date>=input$daterange1[1]&data$Date<=input$daterange1[2],]
    plot(data1$Date, data1$MoodScale, xlab="Date",
         ylab="Mood scale (vary from -5 to 5)", bty="n", pch=16,
         ylim=c(-4,5), col="red")
  })
  
  
  output$plot2 <- renderPlot({
    
    if(input$showModel1){plot(data$WindSpeed..sme2_ws_m.s., data$MoodScale, xlab="Wind Speed (m/s)",
                              ylab="Mood scale (vary from -5 to 5)", bty="n", pch=16,
                              xlim=c(0,7), ylim=c(-4,5), col="green")}
  })
  
  
  output$plot3 <- renderPlot({
    
    if(input$showModel2){plot(data$DaysUntillKayaking, data$MoodScale, xlab="DaysUntillKayaking",
                              ylab="Mood scale (vary from -5 to 5)", bty="n", pch=16,
                              xlim=c(0,365), ylim=c(-4,5),col="blue")}
  })
  
  output$plot4 <- renderPlot({
    
    if(input$showModel3){plot(data$Moon.Phases, data$MoodScale, xlab="Moon.Phases",
                              ylab="Mood scale (vary from -5 to 5)", bty="n", pch=16,
                              ylim=c(-4,5))}
  })
  
  model1<-lm (MoodScale ~ WindSpeed..sme2_ws_m.s.*Moon.Phases+DaysUntillKayaking * Moon.Phases,data = data)
  
  model1pred<-reactive({
    ws<-input$slider1
    duk<-input$slider2
    predict(model1, newdata=data.frame(WindSpeed..sme2_ws_m.s.= ws,DaysUntillKayaking=duk,Moon.Phases=input$variable))
  })
  
  output$pred1 <-renderText({
    
    if(!input$showModel0){model1pred()} else{-100}
  })
  
})

