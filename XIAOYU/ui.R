library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
require(lubridate)
library(dygraphs)
library(xts)
library(leaflet)

shinyUI(navbarPage("Moives", theme = "style.css",
      
 #################### xiaoyu s Menu Item ####################
  tabPanel("Timelines",column(7, 
           sidebarLayout(                          
                         sidebarPanel(
                          
                          conditionalPanel(condition = "input.conditionedPanels == 0",
                                           selectInput("rank", "Rank Status:",
                                                       choices = list( "Rank by Movie Type" = 1, 
                                                                       "Rand by Director" = 2), selected = 1)),
                          
                          conditionalPanel(condition = "input.conditionedPanels == 1",
                                           selectInput("review", "Customer Reviews:",
                                                       choices = list( "Most popular movies" = 1,
                                                                       "Most Active Users" = 2), selected = 1)),
                          
                          conditionalPanel(condition = "input.conditionedPanels == 2 ",
                                           selectInput("time", "Timeline by MovieType:", 
                                                       choices = list("All Types" = 1,
                                                                      "Comedy " = 2,
                                                                      "Action" = 3,
                                                                      "Drama" = 4,
                                                                      "Horror" = 5,
                                                                      "Crime" = 6),selected = 1),
                                           
                                           selectInput("compare", "Between-Types Comparison:", 
                                                       choices = list("NONE" = 1,
                                                                      "Comedy " = 2, 
                                                                      "Action" = 3,
                                                                      "Drama" = 4,
                                                                      "Horror" = 5,
                                                                      "Crime" = 6),selected = 1),
                          
                                           textInput("text", label = h5("Input Year"), value = ""))
                          
                          # conditionalPanel(condition = "input.conditionedPanels == 3",
                          #                  selectInput("status", "Time Spent:", 
                          #                              choices = list("By Boroughs" = 1,
                          #                                             "By ComplaintType" = 2), selected = 1))
                          
                          
             ),
      
            mainPanel(tabsetPanel(id = "conditionedPanels",type="pill",
                                  tabPanel("Ranking", br(),
                                           plotlyOutput("case0", width="1000px",height="600px"),value = 0),
                                  
                                  tabPanel("Reviews", br(),
                                           plotlyOutput("case1", width="1000px",height="600px"),value = 1),
                                  
                                  tabPanel("Timeline",br(),
                                           dygraphOutput("dygraph", width="1000px",height="300px"),
                                           plotlyOutput("case3", width="1000px",height="300px"),value = 2)
                                               
                                                
      ))))),
 #################### end of  xiaoyu s Menu Item ####################  
  
 
 #################### ---- 's Menu Item ####################
    tabPanel("TYPE TWO"
    )
 #################### end of ---- Menu Item  ####################
 
 ))



