box::use(shiny[...])
box::use(shiny.router[...])
#box::use(bslib[...])
box::use(app / data_viewer)
box::use(app / data_utils)


root_page <- div(h2("Root page"))


nav_menu <- tags$nav(
  tags$ul(
    tags$li(
      a(
        href = route_link("/"),
        "Home",
        class = "nav-link active"
      ),
      class = "nav-item"
    ),
    tags$li(
      a(
        href = route_link("viewer"),
        "Data Viewer",
        class = "nav-link"
      ),
      class = "nav-item"
    ),
    class = "nav navbar-nav mr-auto"
  ),
  class = "navbar navbar-light"
)


ui <- fluidPage(
  title = "Databases project",
  #theme = bs_theme(version = 5),
  nav_menu,
  router_ui(
    route("/", root_page),
    route("viewer", data_viewer$ui("data_viewer"))
  )
)

server <- function(input, output, session) {
  router_server()
  ## remove this later when module is finished (autoreload hack)
  box::reload(data_viewer)
  box::reload(data_utils)
  data_viewer$server("data_viewer")
}


shinyApp(ui, server)
