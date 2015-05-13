library("shiny")
library("htmlwidgets")
library("rvest")
library("tm")
library("dplyr")

ui <-
  shinyUI(
    fluidPage(
      tags$link(rel = "stylesheet", type = "text/css", href = "https://bootswatch.com/paper/bootstrap.css"),
      tags$br(),
      fluidRow(
        column(width = 4, class = "well",
               selectInput("url", label = "URL:",
                           choices = c("http://en.wikipedia.org/wiki/R_(programming_language)",
                                       "http://www.htmlwidgets.org/develop_intro.html",
                                       "http://r-pkgs.had.co.nz/intro.html")),
               sliderInput("n_words", label = "Number of words:", min = 10, max = 500, step = 10, value = 200),
               selectInput("font", label = "Font:",
                           choices = c("Impact", "Comic Sans MS (No plz!)" = "Comic Sans MS",
                                       "Arial", "Arial Black", "Tahoma", "Verdana", "Courier New",
                                       "Georgia", "Times New Roman", "Andale Mono")),
               sliderInput("padding", label = "Padding:", min = 0, max = 5, value = 1, step = 1),
               sliderInput("rotate", label = "Rotate:", min = -90, max = 90, value = c(0, 45), step = 5)
               ),
        column(width = 8,
               d3wordcloudOutput("d3wc")
               )
        )
      )
    )

# input <- list(url = "http://en.wikipedia.org/wiki/R_(programming_language)", n_words = 500)
server <- shinyServer(function(input, output) {

  url_data <- reactive({

    url_data <- html(input$url) %>%
      html_nodes("p, li, h1, h2, h3, h4, h5, h6") %>%
      html_text()

    url_data

  })

  output$d3wc <- renderD3wordcloud({

    url_data <- url_data()

    corpus <- Corpus(VectorSource(url_data))

    corpus <- corpus %>%
      tm_map(removePunctuation) %>%
      tm_map(function(x){ removeWords(x, stopwords()) })

    d <- TermDocumentMatrix(corpus) %>%
      as.matrix() %>%
      rowSums() %>%
      sort(decreasing = TRUE) %>%
      data.frame(word = names(.), freq = .) %>%
      tbl_df() %>%
      arrange(desc(freq)) %>%
      head(input$n_words)

    d3wordcloud(d$word, d$freq, font = input$font, padding = input$padding, rotate.min = input$rotate[1], rotate.max = input$rotate[2])
    })
  })

shiny::shinyApp(ui = ui, server = server)
