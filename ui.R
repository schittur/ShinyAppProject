
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(xts)

shinyUI(fluidPage(

  # Application title
  titlePanel("Historical Stock Quote Display"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      textInput("ticker",
                  "Stock symbol:",
                  value = "GOOG",
                  width = 200),
      dateRangeInput('dateRange',
                     label = 'Date range: mm/dd/yyyy', format="mm/dd/yyyy",
                     start = Sys.Date() - 30, 
                     end = Sys.Date()
      ),
      checkboxInput("openChk", "Display Open quote", value = FALSE),
      checkboxInput("highChk", "Display High quote", value = FALSE),
      checkboxInput("lowChk", "Display Low quote", value = FALSE)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      HTML("</hr><h3 style='color:blue'><u>How to use the Application?</u></h2><br>
           <p style='font-family:arial;font-size:12pt;'>
           <b>In the left panel enter the following:</b> <br><br>
           Stock Symbol - enter any valid stock ticker (eg. C, AAPL, K etc..)<br><br>
           Date Range - enter a valid date range for which the stock prices will be displayed<br><br>
           Select additional Open/High and Low quotes which needs to be displayed on the chart.<br>
           </p>
          <p style='font-family:arial;font-size:12pt;color:red;'>
              Quotes are retrived and displayed at runtime from Yahoo Finance</p>
           ")
    )
    
  )
))
