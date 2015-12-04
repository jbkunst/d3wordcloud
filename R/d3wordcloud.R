#' D3 JavaScript Wordcloud Graphs from R
#'
#' Create D3 JavaScript wordcloud
#'
#' @param words The words
#' @param freqs Their frequencies
#' @param padding The separation between words. Default value is `0`.
#' @param colors The color for wordcloud, if the length of words, and colors are the
#' same, then each word will have its own color, in other case a grandien between the colors
#' is generated (the order is important here).
#' @param size.scale The scale to use for scale the words sizes (`freqs`). Options are
#' `linear`, `sqrt` and `log`. Default value is `linear`.
#' @param color.scale The scale to use for scale the colors according to sizes (`freqs`). Options are
#' `linear`, `sqrt` and `log`. Default value is `linear`.
#' @param font The font to use in thw the word cloud. Default value is `Open Sans`.
#' @param spiral The way to construct the wordcloud. Options are
#' `archimedean` and `rectangular`. Default value is `archimedean`.
#' @param rotate.min Minimum angle for (random) rotation. Default value is `-30`.
#' @param rotate.max Maximum angle for (random) rotation. Default value is `30`.
#' @param tooltip Boolean indicating if the cursor is over the text show a tooltip with the size
#' @param rangesizefont A 2 length numeric vector indicating the size of text.
#' @param width widget's width
#' @param height widget's height
#'
#' @examples
#'\dontrun{
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
#' d3wordcloud(words, freqs, colors = substr(viridis::viridis(10, 1), 0 , 7))
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
#' # tooltip
#' d3wordcloud(words, freqs, tooltip = TRUE)
#'
#' }
#'
#' @importFrom htmlwidgets shinyWidgetOutput
#' @importFrom htmlwidgets shinyRenderWidget
#'
#'
#' @export
d3wordcloud <- function(words, freqs, colors = NULL, font = "Open Sans",
                        padding = 1,
                        rotate.min = -30, rotate.max = 30,
                        size.scale = "linear",
                        color.scale = "linear",
                        spiral = "archimedean",
                        tooltip = FALSE,
                        rangesizefont = c(10, 90),
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
                     freq = as.numeric(freqs),
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
                      padding = padding,
                      rotmin = rotate.min,
                      rotmax = rotate.max,
                      tooltip = tooltip,
                      rangesizefont = rangesizefont,
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
#' @param outputId outputId
#' @param width widget's width
#' @param height widget's height
#' @export
d3wordcloudOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'd3wordcloud', width, height, package = 'd3wordcloud')
}

#' Widget render function for use in Shiny
#' @param expr expr
#' @param env env
#' @param quoted quoted
#' @export
renderD3wordcloud <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, d3wordcloudOutput, env, quoted = TRUE)
}
