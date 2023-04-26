#' Dynamic plot using shiny
#'
#' @description
#' Wigdets, plotting areas and layouts
#'
#' @return plots
#' @export
#'
#' @examples
shinyplots <- function(){
  shiny::runApp(system.file("shinyttest", package ="ADVTTEST"),
                launch.browser = TRUE)
}
