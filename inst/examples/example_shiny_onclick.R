library("shiny")
library("htmlwidgets")
library("rvest")
library("dplyr")
library("d3wordcloud")

words <- c("Lorem","ipsum","dolor","sit","amet","consectetur","adipisicing","elit",
           "sed","do","eiusmod","tempor","incididunt","ut","labore","et","dolore",
           "magna","aliqua")
freq <- sample(1:length(words))


d3wordcloud(words, freq, font = "Erica One", padding = 5)


ui <-
  shinyUI(
    fluidPage(
      tags$link(rel = "stylesheet", type = "text/css", href = "https://bootswatch.com/paper/bootstrap.css"),
      tags$br(),
      fluidRow(
        column(width = 12,
               d3wordcloudOutput("d3wc"),
               verbatimTextOutput("selectedWord")
        )
      )
    )
  )

server <- shinyServer(function(input, output) {

  output$selectedWord <- renderPrint({
    paste0("Word clicked: ",input$d3wordcloud_click)
  })
  output$d3wc <- renderD3wordcloud({
    d3wordcloud(words, freq)
  })
})

shiny::shinyApp(ui = ui, server = server)
