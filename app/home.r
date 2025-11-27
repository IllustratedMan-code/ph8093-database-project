box::use(shiny[...])
box::use(. / data_utils)
box::use(utils[...])

unique_uses <- nrow(data_utils$query("select * from Uses"))
unique_side_effects <- nrow(data_utils$query("select * from Side_effects"))
unique_components <- nrow(data_utils$query("select * from Components"))
unique_medications <- nrow(data_utils$query("select * from Medications"))

ui <- function(id = "home") {
  ns <- NS(id)
  fluidPage(
    h1("Data source"),
    tags$ul(tags$li(tags$a("kaggle link", href = "https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details"))),
    h1("Data Summary"),
    tags$table(
      tags$tr(tags$td("Unique Medications"), tags$td(unique_medications)),
      tags$tr(tags$td("Unique Uses"), tags$td(unique_uses)),
      tags$tr(tags$td("Unique Side Effects"), tags$td(unique_side_effects)),
      tags$tr(tags$td("Unique Components"), tags$td(unique_components)),
      class = "table"
    ),
   h2("Uses"),
   plotly::plotlyOutput(ns("uses")),
   h2("Side Effects"),
   plotly::plotlyOutput(ns("side_effects")),
   h2("Components"),
   plotly::plotlyOutput(ns("components")) 
  )
}

hist_unique <- function(query) {
  table <- data_utils$query(query)
  fig <- plotly::plot_ly(x = table[, 1], type = "histogram")
  fig |> plotly::layout(xaxis = list(showticklabels = F, categoryorder = "total descending"))
}

server <- function(id = "home") {
  moduleServer(
    id,
    function(input, output, session) {
      output$stats <- DT::renderDT(stats_table())
      output$uses <- plotly::renderPlotly(hist_unique("select Use from Medications_Uses"))
      output$side_effects <- plotly::renderPlotly(hist_unique("select `Side Effect` from Medications_Side_effects"))
      output$components <- plotly::renderPlotly(hist_unique("select `Component Name` from Medications_Components"))
    }
  )
}
