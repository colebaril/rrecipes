#' @param search_recipes
#' Searches recipe websites for recipes.
#' @return search_recipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export

search_recipes <- function(query, site){

  if("allrecipes" == site){
    search_allrecipes(query)
  } else if ("foodnetwork" == site){
    search_foodnetwork(query)
  } else if ("pioneerwoman" == site){
    search_pioneerwoman()
  }

  else stop('No correct recipe sites entered. Supported sites include "allrecipes" and "foodnetwork".')
}



