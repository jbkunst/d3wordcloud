library(shiny)
library(htmlwidgets)

ui <-
  shinyUI(
    bootstrapPage(
      sliderInput("n_words", label = "Number of words:", min = 10, max = 1000, step = 5, value = 10),
      fluidRow(column(6, d3wordcloudOutput("d3wc")))
      )
    )

server <- shinyServer(function(input, output) {

  output$d3wc <- renderD3wordcloud({

    library("tm")
    library("dplyr")
    library("htmlwidgets")

    data(crude)

    d <- tm_map(crude, removePunctuation) %>%
      tm_map(function(x){ removeWords(x, stopwords()) }) %>%
      TermDocumentMatrix(crude) %>%
      as.matrix() %>%
      rowSums() %>%
      sort(decreasing = TRUE) %>%
      data.frame(word = names(.), freq = .) %>%
      tbl_df() %>% arrange(desc(freq)) %>%
      head(input$n_words)

    d3wordcloud(d$word, d$freq)
    })
  })

shiny::shinyApp(ui = ui, server = server)
