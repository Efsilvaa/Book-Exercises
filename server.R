
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
#install.packages('exams')
source('helper.R')

#build.test()

shinyServer(function(input, output) {
  
  output$textoutput <- renderText('Press "Build Exam!"')
  
  observeEvent(input$goButton, {
    
    lan <- input$lan
    chapter <- input$chapter

    #output$showdlbt <- textOutput('1')
    build.test(lan = lan, 
               chapter = chapter)
    
    output$textoutput <- renderText('Complete. Download file')
    
  })
  
  #output$textoutput <- renderText(paste0('teste ',runif(1)))
  
  output$downloadData <-  downloadHandler(
    filename = function() {
      paste0('ExercisesR','.zip')
    },
    content = function(file) {
      zipout<- paste0('ExercisesR','.zip')
      
      if (!file.exists(zipout)) stop('Error! cant find zip file!')
      #build.test()
      file.copy(zipout, file)
    },
    contentType = "application/zip")
  
})
