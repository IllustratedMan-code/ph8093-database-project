box::use(shiny[...])
box::use(utils[...])
box::use(. / data_utils)



make_imgs <- function(url) {
  sprintf("<img src='%s' height='100'></img>", url)
}

make_pie <- function(high, med, low) {
  plotly::plot_ly(
    labels = c("Poor Review", "Average Review", "Excellent Review"),
    values = c(low, med, high),
    type = "pie"
  )
}

make_scatter <- function(highlight) {
  is_highlighted <- data_utils$csv[["Medicine Name"]] %in% highlight
  p <- plotly::plot_ly()
  p <- p |>
    plotly::add_trace(
      data = data_utils$csv[!is_highlighted, ],
      x = ~`Poor Review %`,
      y = ~`Average Review %`,
      color = ~`Excellent Review %`,
      text = ~`Medicine Name`,
      type = "scatter",
      mode = "markers",
      marker = list(size = 8, opacity = 0.7),
      name = "Medicines"
    )
  p <- p |> plotly::add_trace(
    data = data_utils$csv[is_highlighted, ],
    x = ~`Poor Review %`,
    y = ~`Average Review %`,
    text = ~`Medicine Name`,
    type = "scatter",
    mode = "markers",
    marker = list(
      size = 15,
      color = "red",
      opacity = 0.9,
      line = list(color = "darkred", width = 2)
    ),
    name = "Highlighted"
  )
  p
}

#' @export
html_image <- function(csv) {
  csv["Image URL"] <- lapply(csv["Image URL"], FUN = make_imgs)
  # csv["Plot"] <- mapply(make_plotly, csv[["Poor Review %"]], csv[["Average Review %"]], csv[["Excellent Review %"]])
  csv
}

#' @export
ui <- function(id = "data_viewer") {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      column(6, DT::DTOutput(ns("data"), height = "50%")),
      column(4, fluidPage(plotly::plotlyOutput(ns("pie_chart"))), plotly::plotlyOutput(ns("scatter_plot")))
    )
  )
}


#' @export
server <- function(id = "data_viewer") {
  moduleServer(
    id,
    function(input, output, session) {
      output$data <- DT::renderDT(html_image(data_utils$csv), escape = F)
      
      make_scatter_no_block <- ExtendedTask$new(function(selected) {
        promises::future_promise({
          selected <- data_utils$csv[selected, ]
          make_scatter(selected[["Medicine Name"]])
        })
      })

      make_pie_no_block <- ExtendedTask$new(function(data_rows_selected) {
        promises::future_promise({
          selected <- data_utils$csv[data_rows_selected, ]
          if (nrow(selected) == 0) {
            return(plotly::plot_ly() |>
              plotly::layout(
                title = "Select a row to view chart",
                xaxis = list(visible = FALSE),
                yaxis = list(visible = FALSE)
              ))
          }
          selected <- colSums(selected[c("Excellent Review %", "Average Review %", "Poor Review %")])
          make_pie(selected["Excellent Review %"], selected["Average Review %"], selected["Poor Review %"])
        })
      })
      
      observeEvent(input$data_rows_selected,
        {
          make_scatter_no_block$invoke(input$data_rows_selected)
          make_pie_no_block$invoke(input$data_rows_selected)
        },
        ignoreNULL = F
      )
      output$pie_chart <- plotly::renderPlotly({
        make_pie_no_block$result()
      })
      output$scatter_plot <- plotly::renderPlotly({
        make_scatter_no_block$result()
      })
    }
  )
}
