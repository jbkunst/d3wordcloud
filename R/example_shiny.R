library(shiny)
library(htmlwidgets)

ui <-
  shinyUI(fluidPage(
    titlePanel("Shniy Testing"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("n_words", label = "Number of words:", min = 10, max = 500, step = 10, value = 200),
        selectInput("font", label = "Font:",
                    choices = c("Impact", "Comic Sans MS (No plz!)" = "Comic Sans MS", "Arial", "Arial Black",
                                "Tahoma", "Verdana", "Courier New", "Georgia", "Times New Roman", "Andale Mono")),
        sliderInput("padding", label = "Padding:", min = 0, max = 20, value = 1),
        sliderInput("angle", label = "Rotate:", min = -90, max = 90, value = c(0, 0))
      ),
      mainPanel(
        d3wordcloudOutput("d3wc")
      )
    )
  ))

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

    d3wordcloud(d$word, d$freq, font = input$font, padding = input$padding, min.angle = input$angle[1], max.angle = input$angle[2])
    })
  })

shiny::shinyApp(ui = ui, server = server)
