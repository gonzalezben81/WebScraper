# Define server logic required to pull webdata
server <- function(input, output) {
      
  output$site <- renderUI({
    tags$a(href = input$website, input$website,target="_blank")
  })
  
  observeEvent(input$do, {
    cat("Getting", input$text, "Data")
  })
  
  df <- eventReactive(input$do, {
    withProgress(message = 'Running',
                 value = 0, {
                   for (i in 1:3) {
                     incProgress(1/2)
                     Sys.sleep(0.25)
                   }
                 },env = parent.frame(n=1))
    seven<-(input$text)
    value<-read_html(seven) %>%
      html_nodes(input$node) %>%
      html_text()
    
  })
   # output$printoutput <- renderPrint({
   #   withProgress(message = 'Running',
   #                value = 0, {
   #                  for (i in 1:3) {
   #                    incProgress(1/2)
   #                    Sys.sleep(0.25)
   #                  }
   #                },env = parent.frame(n=1))
   #      seven<-(input$text)
   #      value<-read_html(seven) %>%
   #      html_nodes(input$node) %>%
   #      html_text()
   #      print(value)
   #  
   # 
   # 
   #   })
   
  output$printoutput <- renderPrint({
    print(df())
  })
  
    tabledata<- reactive({

      seven<-(input$text)
     value<-read_html(seven) %>%
       html_nodes(input$node) %>%
       html_text()
     # value<-paste(value,collapse = "\\n")
     print(value)
    })
   
    output$download <- downloadHandler(
      filename = function() { paste("Text",input$name, sep='',".txt") },
      content = function(file) {
        write.table(tabledata(), file)
        
      })

   

}
