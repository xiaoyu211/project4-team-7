library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
require(lubridate)
library(dygraphs)
library(xts)
library(leaflet)

##
movie <- readRDS("~/Desktop/data.rds")
score <- readRDS("~/Desktop/score.rds")
TYPE <- readRDS("~/Desktop/TYPE.Rds")
Final <- readRDS("~/Desktop/Final.Rds")

#shinyserver
shinyServer(function(input, output) {
  
#################### xiaoyu s Menu Item ####################
  ########pie chart
  output$case0 <- renderPlotly({
    
    if(input$rank == 1) {
      
      summary <- sort(summary(movie$Type),decreasing = T)
      B <- data.frame(Type = names(summary), number = summary)
      rownames(B) <- NULL
      B <- B[c(1:15),]
      plot_ly(B, labels = Type, values = number, type = "pie") %>% 
        layout(title = "Number of Movies by Type")
      
    }
    else {
      
      summary <- sort(summary(movie$Director),decreasing = T)
      A <- data.frame(Director = names(summary), number = summary)
      rownames(A) <- NULL
      A <- A[-c(1,2),]
      A <- A[c(1:30),]
      plot_ly(A, labels = Director, values = number, type = "pie") %>% 
        layout(title = "Number of Movies by Director")
      
    }
    
  })
  
  #########review
  output$reveiw0 <- renderPlotly({
    
    if(input$review == 1){
      
      plot_ly(score, x = title.y, y = summary, color = summary, size = summary, mode = "markers")%>%
        layout(xaxis = list(title = "", tickfont = list(size = 7), tickangle = 30), 
               yaxis = list(title = "The total number of reviews"),title = "Top 50 Movies")
    
      }
    
    else{
    
      plot_ly(score, x = review, y = n, size = n, color = n, mode = "markers") %>%
        layout(xaxis = list(title = "", tickfont = list(size = 7), tickangle = 30),
               yaxis = list(title = "The total number of reviews"),title = "Top 50 Active Users")
    
      }
    
    })
  
  output$reveiw1 <- renderPlotly({
    
    if(input$more == 1){
      plot_ly(Final, x = Type, y = summary, mode = "markers",color = summary) %>%
        layout(xaxis = list(title = "", tickfont = list(size = 12), tickangle = 30),
               title = "Overall Ranking")
    }
    
    else {
      plot_ly(Final, x = Type,  y = summary, type = "box")  %>%
        layout(xaxis = list(title = "", tickfont = list(size = 12), tickangle = 30),
               title = "Summary")
      
      }
    
    })
  

  ############Timeline############
    output$dygraph <- renderDygraph({
      data <- switch(input$time, 
                     "1" = TYPE[,1],
                     "2" = TYPE[,2],
                     "3" = TYPE[,3],
                     "4" = TYPE[,4],
                     "5" = TYPE[,5],
                     "6" = TYPE[,6],
                     "7" = TYPE[,7])
      
      data2 <- switch(input$compare, 
                      "1" = NULL,
                      "2" = TYPE[,2],
                      "3" = TYPE[,3],
                      "4" = TYPE[,4],
                      "5" = TYPE[,5],
                      "6" = TYPE[,6],
                      "7" = TYPE[,7])
      
      data3 <- cbind(data,data2)
      name <- paste(names(data),"    ", names(data2))
      dygraph(data3, main = "Between-Types Comparison") %>% dyRangeSelector()
      
    })
    
    #input timeline
    output$case3 <- renderPlotly({
      
      text <- input$text
      search <- sort(summary(movie$Type[movie$Year == text]),decreasing = T)
      search <- data.frame(names = names(search), search)
      rownames(search) <- NULL
      search <- search[1:15,]
      
      plot_ly(search, x = names, y = search, size = search, color = search, mode = "markers") %>%
        layout(xaxis = list(title = "", tickfont = list(size = 11), tickangle = 20),
               yaxis = list(title = "The total number of movies"))
      
    })
  #################### end of  xiaoyu s Menu Item ####################  
  })