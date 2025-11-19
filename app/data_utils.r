box::use(shiny[...])
box::use(utils[...])




#' @export
query <- function(query_string) {
  con <- DBI::dbConnect(RSQLite::SQLite(), "data/11000-medicines.db")
  df <- DBI::dbGetQuery(con, query_string)
  DBI::dbDisconnect(con)
  df
}


#' @export
csv <- query("select * from Medications")
