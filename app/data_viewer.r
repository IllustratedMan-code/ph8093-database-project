box::use(shiny[...])
box::use(utils[...])
box::use(./data_utils)


make_imgs <- function(url){
  sprintf("<img src='%s' height='100'></img>", url)
}


#' @export
import_csv <- function(csv) {
    csv$Image.URL <- lapply(csv$Image.URL, FUN = make_imgs)
    csv
}

#' @export
ui <- function(id="data_viewer"){
    ns <- NS(id)
    fluidPage(DT::DTOutput(ns("data"), width = "40%", height = "50%"), p("hoo there"))
}


#' @export
server <- function(id="data_viewer") {
    moduleServer(
        id,
        function(input, output, session) {
            output$data <- DT::renderDT(import_csv(data_utils$csv))
        }
)
}
