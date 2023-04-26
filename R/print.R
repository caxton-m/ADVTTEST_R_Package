#' Print function prints to the command line  A (1-alpha)100% confidence
#' interval for mu_x - mu_y and the type of test
#'
#' @param x named list of myttest function
#' @param ... from print
#'
#' @return the confidence interval and type of test
#' @export print.Rttest
#'
#' @export
#'
#' @examples
print.Rttest = function(x, ...) {

  ci        = x$conf_inter  # store the confidence interval
  test_type = x$test_type   # store the type of test

  # create a list with summary data and return it
  pr_list = list(ci = ci, test_type = test_type)

  return(pr_list)
}
