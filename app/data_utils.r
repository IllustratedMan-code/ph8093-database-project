box::use(shiny[...])
box::use(utils[...])

# This file adds various utility functions and objects
# for dealing with the database.




## Not really sure how the packaging works when deploying to shiny.io;
## for example, I had to require("future"), but didn't have to for DBI
## possible it is already included in shiny or some other package.

#' @export
query <- function(query_string) {
  con <- DBI::dbConnect(RSQLite::SQLite(), "data/11000-medicines.db")
  df <- DBI::dbGetQuery(con, query_string)
  DBI::dbDisconnect(con)
  df
}


## Potential future direction for the project
## a custom distance metric
#' @export
distance <- function(med1, med2){
  
  }



## a function to convert R vectors to sql lists for queries
#' @export
to_sql <- function(vec) {
  paste0("('", paste(vec, collapse = "', '"), "')")
}


## The main table. It's called csv for backwards
## compatibility (if we're being generous).

#' @export
csv <- query("select * from Medications")
