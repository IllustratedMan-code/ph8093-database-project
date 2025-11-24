box::use(shiny[...])
box::use(. / data_utils)
box::use(utils[...])

stats_table <- function() {
  unique_uses <- nrow(data_utils$query("select * from Uses"))
  t(data.frame("uses" = unique_uses, "uses2" = unique_uses))
}

ui <- function(id = "home") {
  ns <- NS(id)
  fluidPage(DT::DTOutput(ns("stats")))
}



server <- function(id = "home") {
  moduleServer(
    id,
    function(input, output, session) {
      output$stats <- DT::renderDT(stats_table())
    }
  )
}
