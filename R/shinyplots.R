#' Dynamic plot using shiny
#'
#' @description
#' Wigdets, plotting areas and layouts
#'
#' @return plots and print output of package
#' @export
#'
#' @examples
#' \dontrun{ shinyplots()}
shinyplots <- function(){
  shiny::runApp(system.file("shinyttest", package ="ADVTTEST"),
                launch.browser = TRUE)
}
