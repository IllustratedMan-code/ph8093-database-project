box::use(shiny[...])
box::use(utils[...])
box::use(. / data_utils)

# The data viewer page

## I went with a functional design paradigm
## which isn't always the best when working with data,
## but the object oriented design in R is
## terrible and I didn't want to cry (too much).


## converts image urls into html image elements
make_imgs <- function(url) {
  sprintf("<img src='%s' height='100'></img>", url)
}

## makes a pie chart of the sum of reviews selected by the user
make_pie <- function(high, med, low) {
  plotly::plot_ly(
    labels = c("Poor Review", "Average Review", "Excellent Review"),
    values = c(low, med, high),
    type = "pie"
  )
}

## query convenience function (is there such a thing as too much abstraction?)
query_for <- function(names, table, column = "Medicine Name") {
  sql_names <- data_utils$to_sql(names)
  q <- glue::glue("select * from {table} where \"{column}\" in {sql_names}")
  print(q)
  data_utils$query(q)
}

## finds meds that share at least one attribute (i.e. Usage)
similar_meds <- function(med_names, table, column) {
  selected <- query_for(med_names, table)
  print("nrows")
  print(nrow(selected))
  q <- query_for(selected[[column]], table, column)
  q[["Medicine Name"]]
}

## makes the interactive scatter plot
## the scatter plot adds markers when a medicine is selected and provides filters
## based on the selected medications.
## This is a slow operation, so I had to use futures, however the async programming
## paradigm in R is still terrible as there is no easy way to handle fast repetitive calls,
## all functions are just added to the stack instead of executed immediately.
make_scatter <- function(highlight, similar_usage = F, similar_side_effect = F, similar_composition = F) {
  is_highlighted <- data_utils$csv[["Medicine Name"]] %in% highlight
  df <- data_utils$csv
  selected <- df[is_highlighted, ]
  print(head(selected))
  if (similar_usage && (nrow(selected) > 0)) {
    df <- df[df[["Medicine Name"]] %in% similar_meds(selected[["Medicine Name"]], "Medications_Uses", "Use"), ]
  }
  if (similar_side_effect && (nrow(selected) > 0)) {
    df <- df[df[["Medicine Name"]] %in% similar_meds(selected[["Medicine Name"]], "Medications_Side_effects", "Side Effect"), ]
  }
  if (similar_composition && (nrow(selected) > 0)) {
    df <- df[df[["Medicine Name"]] %in% similar_meds(selected[["Medicine Name"]], "Medications_Components", "Component Name"), ]
  }
  p <- plotly::plot_ly()

  p <- p |>
    plotly::add_trace(
      data = df[!(df[["Medicine Name"]] %in% selected[["Medicine Name"]]), ],
      x = ~`Poor Review %`,
      y = ~`Average Review %`,
      text = ~`Medicine Name`,
      type = "scatter",
      mode = "markers",
      marker = list(
        size = 8,
        opacity = 0.7,
        color = ~`Excellent Review %`, # color goes inside marker list
        colorbar = list(
          orientation = "h",
          y = 1.3, # position below x-axis
          yanchor = "top",
          x = 0.5, # center horizontally
          xanchor = "center",
          len = 0.5, # length as fraction of plot width
          thickness = 15, # height in pixels
          title = list(text = "Excellent Review %", side = "top")
        )
      ),
      name = "Medicines",
      showlegend = TRUE
    )
  p <- p |> plotly::add_trace(
    data = df[df[["Medicine Name"]] %in% selected[["Medicine Name"]], ],
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
  p <- p |>
    plotly::layout(
      legend = list(
        orientation = "h",
        x = 0.5,
        xanchor = "center",
        y = 1.0,
        yanchor = "bottom"
      )
    )
  p
}




## makes the images from the image urls
#' @export
html_image <- function(csv) {
  csv["Image URL"] <- lapply(csv["Image URL"], FUN = make_imgs)
  # csv["Plot"] <- mapply(make_plotly, csv[["Poor Review %"]], csv[["Average Review %"]], csv[["Excellent Review %"]])
  csv
}

## The ui of the page (at least shiny supports a little bit of modularization).
#' @export
ui <- function(id = "data_viewer") {
  ns <- NS(id)
  fluidPage(
    fluidRow(
      column(5, DT::DTOutput(ns("data"), height = "50%")),
      column(
        5,
        plotly::plotlyOutput(ns("pie_chart")),
        fluidRow(
          column(8, plotly::plotlyOutput(ns("scatter_plot"))),
          column(3, checkboxGroupInput(ns("filters"), label = h3("Filter by"), choices = list(
            "Similar Usage" = 1,
            "Similar Side Effects" = 2,
            "Similar Composition" = 3
          )), actionButton(ns("clear"), "Clear Selected"))
        ),
          DT::DTOutput(ns("usage")),
          DT::DTOutput(ns("side_effect")),
          DT::DTOutput(ns("composition"))
        
      )
    )
  )
}

# more query abstraction
query_selected <- function(rows_selected, table) {
  df <- data_utils$csv[rows_selected, ][["Medicine Name"]]
  query_for(df, table, "Medicine Name")[, -1]
}


## The server function, again ExtendedTask is used to handle multiple calls to scatter without freezing the UI too much. Unfortunately, shiny does not support true async, so you can't interrupt the main loop with input.
#' @export
server <- function(id = "data_viewer") {
  moduleServer(
    id,
    function(input, output, session) {
      output$data <- DT::renderDT(html_image(data_utils$csv), escape = F)

      make_scatter_no_block <- ExtendedTask$new(function(selected, similar_usage, similar_side_effects, similar_composition) {
        promises::future_promise({
          selected <- data_utils$csv[selected, ]
          make_scatter(selected[["Medicine Name"]], similar_usage, similar_side_effects, similar_composition)
        })
      })
      proxy <- DT::dataTableProxy("data")
      observeEvent(input$clear, {
        proxy |> DT::selectRows(NULL)
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

      observeEvent(c(input$data_rows_selected, input$filters),
        {
          similar_uses <- 1 %in% input$filters
          similar_side_effects <- 2 %in% input$filters
          similar_composition <- 3 %in% input$filters


          make_scatter_no_block$invoke(input$data_rows_selected, similar_uses, similar_side_effects, similar_composition)

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
      output$usage <- DT::renderDT(query_selected(input$data_rows_selected, "Medications_Uses"))
      output$side_effect <- DT::renderDT(query_selected(input$data_rows_selected, "Medications_Side_effects"))
      output$composition <- DT::renderDT(query_selected(input$data_rows_selected, "Medications_Components"))
    }
  )
}
