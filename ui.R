library(shiny)

shinyUI(fluidPage(
  titlePanel("Prediction of A's mood"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider1","Wind Speed (m/s) at the opposite point of the globe",0,10, value=1),
      sliderInput("slider2","Days Untill Kayaking",0,365, value=30),
      selectInput("variable", "Select Moon Phases:",
                  c("First quarter moon" = "First quarter moon",
                    "Full moon" = "Full moon",
                    "Last quarter moon" = "Last quarter moon",
                    "New moon" = "New moon")),
      checkboxInput("showModel0","Are you in the Underdog", value =FALSE),
      h3("__________________"),
      dateRangeInput("daterange1", "Date range:", start = "2022-01-01", end = "2022-12-31"),
      checkboxInput("showModel1","Show/Hide dependency from Wind Speed", value =TRUE),
      checkboxInput("showModel2","Show/Hide dependency from Days Untill Kayaking", value =TRUE),
      checkboxInput("showModel3","Show/Hide dependency from Moon Phases", value =TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("A's mood on a scale from -10 to 10"),
      span(textOutput("pred1"),  style = "color:blue; font-size:30px; font-family:arial; font-style:bold"),
      plotOutput("plot1"),
      plotOutput("plot2"),
      plotOutput("plot3"),
      plotOutput("plot4")
    )
  ),
  
  hr(),
  
  fluidRow(
    column(4, h3("Prediction of A's mood"), h5("by Irina S")),
    column(6, 
           h3("Synopsis"),
           p("After several years of communication with my friend A. it was revealed that constructiveness of conversation can be achieved only if he is in a good mood."),
           p("On the reverse side if he is in a bad mood discussion not only won’t bear fruit but it can have even negative consequences in terms of patience and reasonableness."),
           p("So in 2022 it was decided to track his mood on scale from -10 to 10 (where -10 – extremely aggressive behavior, 10 – polite and very sympathetic)."),
           p("After a long study it turned out that the following factors have the greatest influence on his behavior:"),
           HTML("<ol>
                <li> Wind Speed (m/s) at the opposite point of the globe</li>
                <li> Days Untill annual Kayaking</li>
                <li> Moon Phases</li>
                <li> Is he in a pizzeria Underdog?</li>
                </ol>"),
           p("Since Negative Influence on his mood in pizzeria Underdog is so significant that neutralizes  all the other variables => it was withdrawn from analyzing historical trend."),
           h3("Instructions"),
           p("This article can be used for following purposes"),
           HTML("<ol>
                <li> For A’s mood prediction on a scale [-10,10] if you enter necessary variables (Wind Speed, Days Untill annual Kayaking, Moon Phases, location  relative to Underdog). Linear regression model was used for the analysis. </li>
                <li> For following graphics investigation:</li>
                <ul>
                  <li>A’s mood  Historical Trend (you can specify precise period if you need but in that period)</li>
                  <li>Dependencies if Moods by Wind Speed/ Days Untill annual Kayaking/ Moon Phases. If this info is unnecessary – you can hide this graphic with checkboxes.</li>
                </ul>
                </ol>")
    ))
))
