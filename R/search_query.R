#' @title rrecipes
#' @description Test
#' @param search_query
#' Searches websites for recipes based on recipe_urls()
#' @return search_query
#' @export

query <- function(query) {
  assign("search_allrecipes_query", query, envir=.GlobalEnv)
  query <- list(query)
}





