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
d <- d %>% head(500)

d3wordcloud(d$word, d$freq)
