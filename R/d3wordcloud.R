#' D3 JavaScript Wordcloud Graphs from R
#'
#' Create D3 JavaScript wordcloud
#'
#'
#' @examples
#' library("tm")
#' library("dplyr")
#' library("viridis")
#'
#' data(crude)
#' crude <- tm_map(crude, removePunctuation)
#' crude <- tm_map(crude, function(x){ removeWords(x, stopwords()) })
#' tdm <- TermDocumentMatrix(crude)
#' m <- as.matrix(tdm)
#' v <- sort(rowSums(m), decreasing = TRUE)
#' d <- data.frame(word = names(v), freq = v)
#' d <- d %>% tbl_df()
#' d <- d %>% arrange(desc(freq))
#' d <- d %>% head(100)
#'
#' words <- d$word
#' freqs <- d$freq
#'
#' set.seed(123)
#' colors <- replicate(length(words), {
#'   paste0(c("#", sample(c(c(0:9),  LETTERS[1:6]), size = 6, replace = TRUE)), collapse = "")
#' })
#'
#' # Simple
#' d3wordcloud(words, freqs)
#'
#' # Colors
#' d3wordcloud(words, freqs, colors = "#FFAA00")
#' d3wordcloud(words, freqs, colors = colors)
#' d3wordcloud(words, freqs, colors = c("#000000", "#0000FF", "#FF0000"))
#' d3wordcloud(words, freqs, colors = substr(viridis(10, 1), 0 , 7))
#'
#' # Fonts
#' d3wordcloud(words, freqs, font = "Erica One", padding = 5)
#' d3wordcloud(words, freqs, font = "Sigmar One", padding = 7)
#'
#' # Spiral
#' d3wordcloud(words,freqs, spiral = "archimedean") # default
#' d3wordcloud(words,freqs, spiral = "rectangular")
#'
#' # Scale Size
#' d3wordcloud(words,freqs, size.scale = "linear") # default
#' d3wordcloud(words,freqs, size.scale = "log")
#' d3wordcloud(words,freqs, size.scale = "sqrt")
#'
#' # Scale Color
#' ## Just work only when you put some colors with length(colors) != length(words)
#' colors <- substr(viridis::viridis(3), 0 , 7)
#' d3wordcloud(words,freqs, colors = colors, color.scale = "linear") # default
#' d3wordcloud(words,freqs, colors = colors, color.scale = "log")
#' d3wordcloud(words,freqs, colors = colors, color.scale = "sqrt")
#'
#' # Rotation
#' d3wordcloud(words, freqs, rotate.min = 0, rotate.max = 0)
#' d3wordcloud(words, freqs, rotate.min = 45, rotate.max = 45)
#' d3wordcloud(words, freqs, rotate.min = -180, rotate.max = 180)
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @importFrom htmlwidgets shinyRenderWidget
#'
#'
#' @export
d3wordcloud <- function(words, freqs, colors = NULL, font = "Open Sans",
                        font.weight = 400, padding = 1,
                        rotate.min = -30, rotate.max = 30,
                        size.scale = "linear",
                        color.scale = "linear",
                        spiral = "archimedean",
                        width = NULL, height = NULL)
{

  stopifnot(length(words) == length(freqs),
            length(freqs) > 0,
            size.scale %in% c("log", "sqrt", "linear"),
            color.scale %in% c("log", "sqrt", "linear"),
            spiral %in% c("archimedean", "rectangular"))

  missing_colors <- missing(colors)

  if (!missing_colors) {
    # http://www.mkyong.com/regular-expressions/how-to-validate-hex-color-code-with-regular-expression/
    stopifnot(grepl("^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", colors))
  }

  data <- data.frame(text = as.character(words),
                     size = as.numeric(freqs), stringsAsFactors = FALSE)

  every_word_has_own_color <- length(colors) == length(words)

  if (every_word_has_own_color) {
    data$color <- colors
  }

  if (length(colors) == 1) colors <- c(colors, colors)

  # forward options using x
  x = list(
          data = data,
          pars = list(font = font,
                      fontweight = font.weight,
                      padding = padding,
                      rotmin = rotate.min,
                      rotmax = rotate.max,
                      sizescale = size.scale,
                      colorscale = color.scale,
                      spiral = spiral,
                      colors = colors,
                      every_word_has_own_color = every_word_has_own_color,
                      missing_colors = missing_colors)
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
