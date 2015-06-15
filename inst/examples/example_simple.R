library("tm")
library("dplyr")



data(crude)
crude <- tm_map(crude, removePunctuation)
crude <- tm_map(crude, function(x){ removeWords(x, stopwords()) })
tdm <- TermDocumentMatrix(crude)
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
d <- d %>% tbl_df()
d <- d %>% arrange(desc(freq))
d <- d %>% head(500)

d3wordcloud(d$word, d$freq, font = "Erica One", padding = 5)
d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 5)

d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 1)
d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 1, font.weight = 500)
d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 1, font.weight = 800)
