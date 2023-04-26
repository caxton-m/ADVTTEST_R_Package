#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("T-Test and WELCH testing"),

    # Sidebar with input for number of testing data
    sidebarLayout(
        sidebarPanel(
          sliderInput("df_length", "Length of X and Y:", min = 1, max = 50, value = 30),
          numericInput("x_mean"  , "X mean:"           , min = 1, max = 50, value = 10),
          numericInput("y_mean"  , "Y mean:"           , min = 1, max = 50, value = 8),
          numericInput("x_sd"    , "X standard dev:"   , min = 1, max = 50, value = 15),
          numericInput("y_sd"    , "Y standard dev:"   , min = 1, max = 50, value = 15),
          numericInput("alpha"   , "Alpha:"            , min = 0, max = 1, value = 0.05)
        ),

        # Show a plot and print of the generated
        mainPanel(
          tabsetPanel(type = "tab",
                      tabPanel("Print", verbatimTextOutput("distPrint")),
                      tabPanel("Plot" , plotOutput("distPlot"))
                      )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPrint <- renderPrint({

      # Set the seed for testing data
      set.seed(32); x=rnorm(input$df_length, mean = input$x_mean, sd = input$x_sd)
      set.seed(35); y=rnorm(input$df_length, mean = input$y_mean, sd = input$y_sd)

      # call the ADVTTEST Package
      ans1 = ADVTTEST::myttest(x,y, alpha = input$alpha, paired = FALSE)

      # print the confidence interval and test type
      print(ans1)
    })

    output$distPlot <- renderPlot({

      # Set the seed for testing data
      set.seed(32); x=rnorm(input$df_length, mean = input$x_mean, sd = input$x_sd)
      set.seed(35); y=rnorm(input$df_length, mean = input$y_mean, sd = input$y_sd)

      # call the ADVTTEST Package
      ans1 = ADVTTEST::myttest(x,y, alpha = input$alpha, paired = FALSE)

      # plot the boxplots
      plot(ans1)

    })
}

# Run the application
shinyApp(ui = ui, server = server)
