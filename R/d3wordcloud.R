#' D3 JavaScript Wordcloud Graphs from R
#'
#' Create D3 JavaScript wordcloud
#'
#' 
#' @examples 
#' library("tm")
#' library("dplyr")

#'data(crude)
#'crude <- tm_map(crude, removePunctuation)
#'crude <- tm_map(crude, function(x){ removeWords(x, stopwords()) })
#'tdm <- TermDocumentMatrix(crude)
#'m <- as.matrix(tdm)
#'v <- sort(rowSums(m), decreasing = TRUE)
#'d <- data.frame(word = names(v), freq = v)
#'d <- d %>% tbl_df()
#'d <- d %>% arrange(desc(freq))
#'d <- d %>% head(500)

#'d3wordcloud(d$word, d$freq, font = "Erica One", padding = 5)
#'d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 5)

#'d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 1)
#'d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 1, font.weight = 500)
#'d3wordcloud(d$word, d$freq, font = "Open Sans", padding = 1, font.weight = 800)
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @importFrom htmlwidgets shinyRenderWidget
#'
#'
#' @export
d3wordcloud <- function(words, freqs, font = "Open Sans", 
                        font.weight = 400, padding = 1, 
                        rotate.min = -30, rotate.max = 30,
                        scale = "linear", spiral = "archimedean", 
                        width = NULL, height = NULL) 
{
        
        if (!(scale %in% c("log", "sqrt", "linear"))){
                stop("Scale must be either linear, log, or sqrt")
        }
        if (!(spiral %in% c("archimedean", "rectangular"))){
                stop("Spiral must be either archimedean or rectangular")
        }
        # forward options using x
        x = list(
                data = data.frame(text = words, size = freqs),
                pars = list(font = font, 
                            fontweight = font.weight, 
                            padding = padding,
                            rotmin = rotate.min, 
                            rotmax = rotate.max,
                            scale = scale, 
                            spiral = spiral)
        )
        
        # create widget
        htmlwidgets::createWidget(
                name = 'd3wordcloud',
                x,
                width = width,
                height = height,
                package = 'd3wordcloud'
        )
}

#' Widget output function for use in Shiny
#'
#' @export
d3wordcloudOutput <- function(outputId, width = '100%', height = '400px'){
        shinyWidgetOutput(outputId, 'd3wordcloud', width, height, package = 'd3wordcloud')
}

#' Widget render function for use in Shiny
#'
#' @export
renderD3wordcloud <- function(expr, env = parent.frame(), quoted = FALSE) {
        if (!quoted) { expr <- substitute(expr) } # force quoted
        shinyRenderWidget(expr, d3wordcloudOutput, env, quoted = TRUE)
}
