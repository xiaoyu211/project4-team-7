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
movie <- movie[,c(2,4,6:9)]
TYPE <- readRDS("~/Desktop/TYPE.Rds")

#shinyserver
shinyServer(function(input, output) {
    
  ########pie chart
  output$case0 <- renderPlotly({
    
    if(input$rank == 1) {
      
      summary <- sort(summary(movie$Type),decreasing = T)
      B <- data.frame(Type = names(summary), number = summary)
      rownames(B) <- NULL
      B <- B[c(1:15),]
      plot_ly(B, labels = Type, values = number, type = "pie") %>% 
        layout(title = "Top Movie Type")
      
    }
    else {
      
      summary <- sort(summary(movie$Director),decreasing = T)
      A <- data.frame(Director = names(summary), number = summary)
      rownames(A) <- NULL
      A <- A[-c(1,2),]
      A <- A[c(1:30),]
      plot_ly(A, labels = Director, values = number, type = "pie") %>% 
        layout(title = "Top Director")
      
    }
  })
  
  #########review
  output$case1 <- renderPlotly({
    
    if(input$review == 1){
      
      plot_ly(score, x = name, y = summary,  size = summary, color = summary ,mode = "markers")%>%
        layout(xaxis = list(title = "", tickfont = list(size = 7), tickangle = 30))
    
      }
    
    else{
    
      plot_ly(score, x = review, y = n, size = n, color = n, mode = "markers") %>%
        layout(xaxis = list(title = "", tickfont = list(size = 7), tickangle = 30))
    
      }
    
    })
  
  #########Timeline
    output$dygraph <- renderDygraph({
      data <- switch(input$time, 
                     "1" = TYPE[,1],
                     "2" = TYPE[,2],
                     "3" = TYPE[,3],
                     "4" = TYPE[,4],
                     "5" = TYPE[,5],
                     "6" = TYPE[,6])
      
      data2 <- switch(input$compare, 
                      "1" = NULL,
                      "2" = TYPE[,2],
                      "3" = TYPE[,3],
                      "4" = TYPE[,4],
                      "5" = TYPE[,5],
                      "6" = TYPE[,6])
      
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
        layout(xaxis = list(title = "", tickfont = list(size = 11), tickangle = 20))
      
    })
    # output$plot <- renderPlotly({
    # 
    #   if (input$status == 1) {
    # 
    #     x <- list(
    #       showticklabels = F
    #     )
    # 
    #     y <- list(
    #       range = c(-2,12)
    #     )
    # 
    #     plot_ly(C, x = Borough, y = Days, color = Borough, type = "box", boxmean = T) %>%
    #       layout(xaxis = x, yaxis = y, title = "Resolution Time by Boroughs")
    # 
    #   }
    # 
    #   else {
    # 
    #     x <- list(
    #       showticklabels = F
    #     )
    # 
    #     z <- list(
    #       range = c(-5,55)
    #     )
    # 
    #     plot_ly(C, x = Complaint.Type, y = Days, color = Complaint.Type, type = "box", boxmean = T) %>%
    #       layout(xaxis = x, yaxis = z, title = "Resolution Time by Boroughs")
    #   }
    # 
    # })
    # 
    # 
    # output$view <- renderTable({
    #   
    #   summary <- data.frame(tapply(
    #     A$Days[A$Status == "Closed"], list(A$Complaint.Type[A$Status == "Closed"], 
    #                                        A$Borough[A$Status == "Closed"]), mean, na.rm=TRUE))
    #   head(summary, n = 8)
    #   
    # })
    # 
    # 
    # 
    # output$case3 <- renderPlotly({  
    #   
    #   if(input$cases == 1) {
    #     
    #     Type <- data.frame(summary(A$Complaint.Type[A$Status == "Open"]))
    #     value <- c(Type[,1])
    #     name <- c(rownames(Type))
    #     plot_ly(values = value, labels = c(name),type="pie", showlegend = F) %>% 
    #       layout(title = "Open cases by Complaint.Type") 
    #     
    #   }
    #   else{
    #     
    #     Type <- data.frame(summary(A$Complaint.Type[A$Status == "Closed"]))
    #     value <- c(Type[,1])
    #     name <- c(rownames(Type))
    #     plot_ly(values = value, labels = c(name),type="pie" ,showlegend = F) %>% 
    #       layout(title = "Closed cases by Complaint.Type") 
    #     
    #   } 
    #   
    # })
    # 
    # output$map <- renderLeaflet({
    #   
    #   leaflet(na.omit(A)) %>% addTiles() %>% addProviderTiles("CartoDB.Positron") %>% 
    #     setView(lng = -73.9857, lat = 40.7577, zoom = 11) %>% 
    #     addCircleMarkers(radius=6, fillOpacity = 0.5, popup = paste(A$Days),
    #                      clusterOptions = markerClusterOptions())
    #   
    # })
  })