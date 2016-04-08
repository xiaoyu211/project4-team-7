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
  tabPanel("Timelines",
           sidebarLayout(position="left",
             sidebarPanel(width = 2,
                        
                        conditionalPanel(condition = "input.conditionedPanels == 0",
                                           selectInput("rank", "Rank Status:",
                                                       choices = list( "Rank by Movie Type" = 1, 
                                                                       "Rank by Director" = 2), selected = 1)
                                         ),
                          
                        conditionalPanel(condition = "input.conditionedPanels == 1",
                                           selectInput("review", "Customer Reviews:",
                                                       choices = list( "Most Popular movies" = 1,
                                                                       "Most Active Users" = 2), selected = 1),
                                           
                                           selectInput("more", "More Details:",
                                                       choices = list("Overall Ranking" = 1,
                                                                      "Summary by Movie Type" = 2), selected = 1),
                                           
                                           textInput("text_id", label = h5("Input Product ID"), value = "")

                                         ),
                          
                        conditionalPanel(condition = "input.conditionedPanels == 2 ",
                                           selectInput("time", "Timeline by MovieType:", 
                                                       choices = list("All Types" = 1,
                                                                      "Comedy " = 2,
                                                                      "Animation" = 3,
                                                                      "Action" = 4,
                                                                      "Drama" = 5,
                                                                      "Horror&Thriller" = 6,
                                                                      "Crime" = 7),selected = 1),
                                           
                                           selectInput("compare", "Between-Types Comparison:", 
                                                       choices = list("NONE" = 1,
                                                                      "Comedy " = 2, 
                                                                      "Animation" = 3,
                                                                      "Action" = 4,
                                                                      "Drama" = 5,
                                                                      "Horror&Thriller" = 6,
                                                                      "Crime" = 7),selected = 1),
                          
                                           textInput("text_year", label = h5("Input Year"), value = ""))
                          
                          
                      ),
           
              mainPanel(width = 10,tabsetPanel(id = "conditionedPanels", type="pill",
                                  tabPanel("Ranking",br(),
                                           plotlyOutput("case0", width="900px",height="600px"),value = 0),
                                  
                                  tabPanel("Popularity",br(),
                                           fluidRow(
                                             column(6,plotlyOutput("reveiw0", width="550px",height="300px")),
                                             column(6,plotlyOutput("reveiw1", width="550px",height="300px")),
                                             column(12,dygraphOutput("reveiw2", width="900px",height="300px"))),value = 1),
                                            
                                  tabPanel("Timeline",br(),
                                           fluidRow(
                                             dygraphOutput("dygraph", width="900px",height="300px"),
                                             plotlyOutput("case3", width="1000px",height="300px")),value = 2)
                                               
                                            ))
    )),
 #################### end of  xiaoyu s Menu Item ####################  
  
 
 #################### ---- 's Menu Item ####################
    tabPanel("TYPE TWO"
    )
 #################### end of ---- Menu Item  ####################
 
 ))



