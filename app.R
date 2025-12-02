box::use(shiny[...])
box::use(shiny.router[...])
# box::use(bslib[...]) ## only needed when bootstrap version is set
box::use(app / data_viewer)
box::use(app / data_utils)
box::use(app / home)
require("plotly")
require("future")
require("shiny")

# Entrypoint file for the app

## Box is used to avoid namespace pollution.
## Future is used to keep the UI snappy even when doing difficult actions.
## Plotly is for interactive plots.


## The app is split into 4 files including this one.
## This file is the entry point (i.e. the main function in other languages).
## There are 2 pages to the app, located in app/data_viewer and app/home.


## This is the bootstrap nonsense I had to do for the routing to work correctly.
## While it still is technically a single page application,
## multiple URLs do exist for the different sections
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

## The UI entry point, just a wrapper
## for the other modules.
ui <- fluidPage(
  title = "Databases project",
  ## bootstrap version 5 breaks the nix support?
  ## I love R!!
  # theme = bs_theme(version = 5),
  nav_menu,
  router_ui(
    route("/", home$ui()),
    route("viewer", data_viewer$ui("data_viewer"))
  )
)


## The server entry point
server <- function(input, output, session) {
  ## remove this later when module is finished (autoreload hack)
  ## box::reload(data_viewer)
  ## box::reload(home)
  ## box::reload(data_utils)

  ## Server calls
  router_server()
  data_viewer$server("data_viewer") ## namespace isn't needed, but is optional
  home$server()
}


## The true entry point (i.e. int main)
shinyApp(ui, server)
