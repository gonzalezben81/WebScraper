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

   ###Rmarkdown Report for WebScraper
    output$webreport<- downloadHandler(
      filename = function() {
        paste('Web Scraper Report','html', sep = '.')
      },
      
      
      
      
      content = function(file) {
        src <- normalizePath('./web.Rmd')
        # temporarily switch to the temp dir, in case you do not have write
        # permission to the current working directory
        # owd <- setwd(tempdir())
        # on.exit(setwd(owd))
        # file.copy(src, './report.Rmd', overwrite = TRUE)
        
        webReport <- file.path(tempdir(), "./web.Rmd")

        file.copy("./web.Rmd", webReport, overwrite = TRUE)

        
        
        library(rmarkdown)
        out <- render(input = 'web.Rmd',output_format = html_document()
                      #               switch(
                      # input$format,
                      # PDF = pdf_document(), HTML = html_document(), Word = word_document()
        )
        file.rename(out, file)
        
        #     # Set up parameters to pass to Rmd document
        params <- list(s = df(),set_author = input$text)
        rmarkdown::render(webReport, output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
        
      }
    )

}
