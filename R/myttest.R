#' Myttest function will investigate the data for evidence for a difference in the population variances
#' if the data supports the conclusion that the underlying variances are likely different or
#' if paired = TRUE then an appropriate t-test is made to produce a list containing:
#'
#' - "Welch", "T-test", "Paired" depending on what test was conducted
#' - A "Y/N" conclusion as to whether we should reject the NULL of equality of means at the alpha level of significance
#' - The summary statistics made by the appropriate t.test in a data list
#'
#' @param x first vector
#' @param y second vector
#' @param alpha confidence interval
#' @param paired experimental unit measurement
#'
#' @importFrom dplyr '%>%' filter
#' @importFrom stats 't.test' 'sd'
#'
#' @return list of the data frame
#' @export
#'
#' @examples
myttest = function(x, y, alpha, paired){
  t.test = NULL

  # create a data frame
  df = data.frame(x = x, y = y)

  # finding the population variance
  sd1 = sd(x)
  sd2 = sd(y)

  # determine conclusion that the underlying variances
  if(paired)                   { test_type = "Paired"; v = FALSE }
  else if (abs(sd1 - sd2) < 5) { test_type = "T-test"; v = TRUE  }
  else                         { test_type = "WELCH "; v = FALSE }

  # make t-test assuming that the variances in the population are the same
  tests = t.test(x = x, y = y,
                 var.equal = v, paired = paired, conf.level = 1 - alpha)

  # find the confidence intervals and p-value
  conf_inter = tests$conf.int
  p_value = tests$p.value

  if(p_value < alpha) { conclusion = "Y" }
  else                { conclusion = "N" }

  # make a named list of function
  fcn_list = list(data = df, alpha = alpha, paired = paired,
                  conf_inter = conf_inter, p_value = p_value,
                  test_type = test_type, conclusion = conclusion)

  # make list to be of class "Rttest"
  class(fcn_list) = "Rttest"

  # return the list
  return(fcn_list)
}
