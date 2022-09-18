#' @title rrecipes
#' @description Test
#' @param search_allrecipes_query
#' Searches allrecipes.com for recipes based on recipe_urls()
#' @return search_allrecipes_query
#' @export

query <- function(query) {
  assign("search_allrecipes_query", query, envir=.GlobalEnv)
  query <- list(query)
}


