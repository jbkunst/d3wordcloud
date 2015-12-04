#' ---
#' title: "R package: d3wordcloud"
#' author: "Joshua Kunst"
#' output:
#'   html_document:
#'     theme: journal
#'     toc: yes
#' ---

#' # Installation

#+ echo=FALSE
#'     devtools::install_github("jbkunst/d3wordcloud")

#' # First Use
library("d3wordcloud")
words <- c("I", "love", "this", "package", "but", "I", "don't", "like", "use", "wordclouds!", "voila")
freqs <- rev(seq(length(words))) + 10

d3wordcloud(words, freqs)

#' # Requeriments for the Examples
#+ warnings=FALSE, message=FALSE
library("d3wordcloud")
library("tm")
library("dplyr")
library("viridis")

data(crude)
crude <- tm_map(crude, removePunctuation)
crude <- tm_map(crude, function(x){ removeWords(x, stopwords()) })
tdm <- TermDocumentMatrix(crude)
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
d <- d %>% tbl_df()
d <- d %>% arrange(desc(freq))
d <- d %>% head(100)

words <- d$word
freqs <- d$freq

#' # Examples

#' ## Simple
d3wordcloud(words, freqs)

#' ## Colors
d3wordcloud(words, freqs, colors = "#FFAA00")

#' Each word has its own color, *only* hedecimal format!
#'
set.seed(123)
colors <- sample(substr(rainbow(length(words)), 0 , 7))
d3wordcloud(words, freqs, colors = colors)

#' We can add a gradient between colors *acording the freq (size)*
d3wordcloud(words, freqs, colors = c("#FF0000", "#00FF00", "#0000FF"))
d3wordcloud(words, freqs, colors = substr(viridis(10, 1), 0 , 7))

#' ## Fonts
#' Only works when you have a web connection and it works only with fonts on https://www.google.com/fonts
#' https://www.google.com/fonts/specimen/Erica+One
d3wordcloud(words, freqs, font = "Erica One", padding = 5)

#' https://www.google.com/fonts/specimen/Anton
d3wordcloud(words, freqs, font = "Anton", padding = 7)

#' ## Spiral
d3wordcloud(words,freqs, spiral = "archimedean") # default
d3wordcloud(words,freqs, spiral = "rectangular")

#' ## Scale Size
d3wordcloud(words,freqs, size.scale = "linear") # default
d3wordcloud(words,freqs, size.scale = "log")
d3wordcloud(words,freqs, size.scale = "sqrt")

#' ## Scale Color
#' Just work only when you put some colors with length(colors) != length(words)
#'
#' The differences between colors are minimal but exists!
colors <- substr(viridis::viridis(3), 0 , 7)
colors
d3wordcloud(words,freqs, colors = colors, color.scale = "linear") # default
d3wordcloud(words,freqs, colors = colors, color.scale = "log")
d3wordcloud(words,freqs, colors = colors, color.scale = "sqrt")

#' ## Rotation
d3wordcloud(words, freqs, rotate.min = 0, rotate.max = 0)
d3wordcloud(words, freqs, rotate.min = 45, rotate.max = 45)
d3wordcloud(words, freqs, rotate.min = -180, rotate.max = 180)

#' ## Tooltips
d3wordcloud(words, freqs, tooltip = TRUE)


#' ## Change size
d3wordcloud(words, freqs, rangesizefont = c(10, 20))

