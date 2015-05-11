library("tm")
library("dplyr")



data(crude)
crude <- tm_map(crude, removePunctuation)
crude <- tm_map(crude, function(x){ removeWords(x, stopwords()) })

#####         from frequency counts     #####
tdm <- TermDocumentMatrix(crude)
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
d <- d %>% tbl_df()
d <- d %>% arrange(desc(freq))
d <- d %>% head(50)

d3wordcloud(d$word, d$freq)


library(shiny)
library(htmlwidgets)

ui <-
  shinyUI(
    bootstrapPage(
      selectInput(inputId = "n_words", label = "Number of words:", choices = c(10, 20, 35, 50), selected = 10),
      fluidRow(column(6, d3wordcloudOutput("d3wc")))
      )
    )

server <- shinyServer(function(input, output) {
  output$d3wc <- renderD3wordcloud({
    library("tm")
    library("dplyr")
    library("htmlwidgets")
    data(crude)
    crude <- tm_map(crude, removePunctuation)
    crude <- tm_map(crude, function(x){ removeWords(x, stopwords()) })

    #####         from frequency counts     #####
    tdm <- TermDocumentMatrix(crude)
    m <- as.matrix(tdm)
    v <- sort(rowSums(m), decreasing = TRUE)
    d <- data.frame(word = names(v), freq = v)
    d <- d %>% tbl_df()
    d <- d %>% arrange(desc(freq))
    d <- d %>% head(input$n_words)

    d3wordcloud(d$word, d$freq)
    })
  })

shiny::shinyApp(ui = ui, server = server)
