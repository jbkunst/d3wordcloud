#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
d3wordcloud <- function(words, freqs, font = "Impact", padding = 1, scale = 1, min.angle = -60, max.angle = 60,
                        width = NULL, height = NULL) {

  # forward options using x
  x = list(
    data = data.frame(text = words, size = freqs),
    pars = list(font = font, paddgin = padding, scale = scale, a = min.angle, b = max.angle)
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
