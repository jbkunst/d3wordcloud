#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
d3wordcloud <- function(words, freqs, font = "Impact", padding = 1, rotate.min = -30, rotate.max = 30,
                        scale = "linear", spiral = "archimedean",
                        width = NULL, height = NULL) {

  # stopifnot(!scale %in% c("log", "sqrt", "linear"))

  # forward options using x
  x = list(
    data = data.frame(text = words, size = freqs),
    pars = list(font = font, padding = padding, rotmin = rotate.min, rotmax = rotate.max,
                scale = scale, spiral = spiral)
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
