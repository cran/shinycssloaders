% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/show-hide.R
\name{showHide}
\alias{showHide}
\alias{showSpinner}
\alias{hideSpinner}
\title{Manually show/hide a spinner}
\usage{
showSpinner(id, expr)

hideSpinner(id)
}
\arguments{
\item{id}{The ID of the Shiny output. The corresponding output must have been
wrapped in \code{\link[=withSpinner]{withSpinner()}} in the UI.}

\item{expr}{(optional) An R expression to run while showing the spinner. The
spinner will automatically get hidden when this expression completes.}
}
\value{
If \code{expr} is provided, the result of \code{expr} is returned. Otherwise, \code{NULL}.
}
\description{
Any Shiny output that uses \code{\link[=withSpinner]{withSpinner()}} will automatically show a spinner
while it's recalculating. Use \code{\link[=showSpinner]{showSpinner()}} and \code{\link[=hideSpinner]{hideSpinner()}} to manually
trigger the spinner on-demand.
}
\examples{
if (interactive()) {
  library(shiny)

  #--- Example 1: Using showSpinner/hideSpinner ---

  shinyApp(
    ui = fluidPage(
      actionButton("show", "Show"),
      actionButton("hide", "Hide"),
      withSpinner(plotOutput("plot"))
    ),
    server = function(input, output) {
      output$plot <- renderPlot({
        plot(runif(10))
      })
      observeEvent(input$show, {
        showSpinner("plot")
      })
      observeEvent(input$hide, {
        hideSpinner("plot")
      })
    }
  )

  #--- Example 2: Using showSpinner with expr ---

  some_slow_function <- function() {
    Sys.sleep(2)
  }

  shinyApp(
    ui = fluidPage(
      actionButton("show", "Show"),
      withSpinner(plotOutput("plot"))
    ),
    server = function(input, output) {
      output$plot <- renderPlot({
        plot(runif(10))
      })
      observeEvent(input$show, {
        showSpinner("plot", { some_slow_function() })
      })
    }
  )
}
}
\seealso{
\code{\link[=withSpinner]{withSpinner()}}
}
