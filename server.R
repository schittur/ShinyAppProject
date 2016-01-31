
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # stock = "C"
    strStartDate = as.character(input$dateRange)[1]
    strEndDate = as.character(input$dateRange)[2]
    url <- paste("http://ichart.finance.yahoo.com/table.csv?s=", input$ticker, "&c=1962", sep="")
    
    dataX <- read.csv(url)
    dataX$Date = as.Date(dataX$Date)
    
    startDate = as.Date(strStartDate)
    endDate = as.Date(strEndDate)
    
    dataX = subset(dataX, (Date >= startDate & Date <= endDate))
    includeCols <- c("Close");
    colors <- c("darkgreen");
    if (input$openChk) { includeCols <- c(includeCols, "Open"); colors <- c(colors, "orange"); }
    if (input$highChk) { includeCols <- c(includeCols, "High"); colors <- c(colors, "blue"); }
    if (input$lowChk) { includeCols <- c(includeCols, "Low"); colors <- c(colors, "red"); }
    
    data.xts <- as.xts(dataX[, includeCols], dataX[,1])
    zoo.basket <- as.zoo(data.xts)
    plot(x = zoo.basket, ylab = "Stock Quote ($)", main = "Historical Stock Price",
         col = colors, screens = 1);
    legend(x = "topleft", legend = includeCols, 
           lty = 1,col = colors);
    
  })

})
