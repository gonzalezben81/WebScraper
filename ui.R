

library(shiny)
library(rvest)
library(dplyr)
library(reshape2)
library(tidytext)
library(tm)
library(corrgram)
library(datasets)
library(xlsx)
library(randomForest)



ui<-shinyUI(fluidPage(
  # tags$head(includeScript("google-analytics.js")),
  theme = "blue.css",
pageWithSidebar(
  headerPanel('Web Scraper'),
  sidebarPanel(
               #tags$style(".well {background-color:white;}"),
    textInput(inputId = "text",label = "Enter Website url:",value = "",placeholder = "Enter valid website here"),
    br(),
    textInput(inputId = "node",label = "HTML Node",value = "",placeholder = "Enter valid CSS selector here"),
    br(),
    # selectInput('website', 'Reference Links'
    #             , list(CSS = "http://www.w3schools.com/css/default.asp"
    #                    , HTML = "http://www.w3schools.com/html/default.asp"
    #                    , JAVA = "http://www.w3schools.com/js/default.asp")
    # ),
    # htmlOutput("site"),
    h4("Reference Links:"),
    br(),
    a(img(src="./CSSTWO.png",width="35",height="35"),href="http://www.w3schools.com/css/default.asp", target="_blank"),
    a(img(src="./html.png",width="35",height="35"),href="http://www.w3schools.com/html/default.asp", target="_blank"),
    a(img(src="./java2.png",width="35",height="35"),href="http://www.w3schools.com/js/default.asp", target="_blank"),
    # 
    br(),
    br(),
    actionButton(inputId = "do",label = "Get Data",icon = icon("gears")),
                 #style="color: #fff; background-color: black; border-color: #2e6da4"),
    br(),
    br(),
    textInput(inputId = "name",label = "Save File As:",value = "",placeholder = "Type File Name Here"),
    # downloadButton('download', 'Download',class = "butt")
    br(),
    downloadButton("download", label="Download"),
    hr(),
    downloadButton(outputId="webreport",label = "Report")
    #tags$head(tags$style(".butt{background-color:black;} .butt{color: white;}"))

  ),
  mainPanel(
    tabsetPanel(selected = "Output",
      tabPanel("Output",
               br(),
               verbatimTextOutput("printoutput"))



    )
  ))))
