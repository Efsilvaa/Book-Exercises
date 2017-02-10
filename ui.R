
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  h1('R Exercises'),
  p('Here you can find exercises from the book ',
    a(' Processamento e Modelagem de Dados Financeiros com o R',href='https://www.amazon.com/dp/8592243513'),
  ', available in Amazon.'),
  p(''),
  p('This shiny app allows you to download exercises for a selection of chapters from the book in either the Portuguese or English language',
  "The content of the exercises is dynamically generated using package ",a('Exams',href='https://cran.r-project.org/package=exams'),
     ". You can learn more about it ",a('here',href = 'https://msperlin.github.io/2017-01-30-Exams-with-dynamic-content/')),
  h2('How to use it'),
  p('Using this shiny app is simple, select the chapters you want exercises, your language of choice and click in Build Exam.',
    'A new pdf file with single choice questions will be generated, along with the solution. Once it is ready, click the Download button.',
    'In the resulting zip file youll find both files.'),
  p(' '),
  p('Curious on the code for this shiny app? Have a look at the code in ',a('github', href='https://github.com/msperlin')),

  
  selectInput('chapter', 'Select a chapter', 
              choices = c('All Chapters',
                          'Chapter-2 Basic Operations',
                          'Chapter-3 Basic Classes'),
              selectize = TRUE),
  selectInput('lan', 'Select a language', 
              choices = c('en',
                          'pt-br'),
              selectize = TRUE),
  
  actionButton("goButton", "Build Exam!"),
  
  textOutput("textoutput"),
  conditionalPanel("output.textoutput=='Complete. Download file'",
  downloadButton("downloadData", 'Download'))
  
  )
)
