#' @title rrecipes
#' @description Test
#' @param search_allrecipes_query
#' Searches allrecipes.com for recipes based on recipe_urls()
#' @return search_allrecipes_query
#' @export

search_allrecipes_query <- function(search_allrecipes_query) {
  assign("search_allrecipes_query", search_allrecipes_query, envir=.GlobalEnv)
  search_allrecipes_query <- list(search_allrecipes_query)
}


