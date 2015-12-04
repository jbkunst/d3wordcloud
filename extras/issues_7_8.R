words <- structure(c(223L, 193L, 146L), .Dim = 3L, .Dimnames = structure(list(
  c(
    "CERTIFIED SERVICE MANAGER (CSM)",
    "CISCO CERTIFIED NETWORK ASSOCIATE",
    "CISCO CERTIFIED NETWORK PROFESSIONAL (CCNP)"
    )), .Names = ""))


library("d3wordcloud")
set.seed(8297)  # This not work, becasue the randomness is via JS, not R.

# This is oop!
d3wordcloud(words= names(words), freqs = as.numeric(words))


# this is adding the new functionality/paramter. Youll need to modify via test/error.
d3wordcloud(words= names(words),
            freqs = as.numeric(words),
            rangesizefont = c(1, 10))


# And finally, tooltips
d3wordcloud(words= names(words),
            freqs = as.numeric(words),
            tooltip = TRUE,
            rangesizefont = c(1, 10))
