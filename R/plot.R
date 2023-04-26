#' An informative plot with the "Rttest" class that creates boxplots of
#' the data when non - paired data is analyzed. It also will make a boxplot of
#' differences in data when paired = TRUE The ci for the difference of means
#' is plotted inside the boxplot of differences.
#'
#' @param x  named list of myttest function
#' @param ... from ggplot function
#'
#' @importFrom ggplot2 'aes' 'geom_boxplot' 'ggplot' 'stat_summary'
#'
#' @return plot of the data frame
#' @export plot.Rttest
#'
#' @export
#'
#' @examples
plot.Rttest = function(x, ...){

  if(x$paired){   # if paired

    data_var = NULL    # the letter of the the data (X)
    value    = NULL    # value of data

    # merge the differences in data of x object
    m_data = data.frame(value = x$data$x - x$data$y, data_var = rep(LETTERS[24]))

    # create the boxplot
    ggplot(m_data, aes(x = data_var , y= value , fill=data_var )) +
      geom_boxplot() + stat_summary(fun=mean, geom="point", shape=23, size=4, fill="white")
  }
  else{           # else if not paired

    data_var = NULL    # the letter of the the data (X or Y)
    value    = NULL    # value of data

    # create separate data sets of x and y
    x_data = data.frame(value = x$data$x, data_var = rep(LETTERS[24]))
    y_data = data.frame(value = x$data$y, data_var = rep(LETTERS[25]))

    # merge the x and y data into new data set
    merge_data = merge(x = x_data, y = y_data, all = TRUE)

    # create the boxplot
    ggplot(merge_data, aes(x = data_var , y= value , fill=data_var )) +
      geom_boxplot()
  }
}
