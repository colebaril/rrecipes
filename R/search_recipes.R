#' @param search_recipes
#' Searches recipe websites for recipes.
#' @return search_recipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export

search_recipes <- function(query, site, number){

  if("allrecipes" == site){
    search_allrecipes(query, number)
  } else if ("foodnetwork" == site){
    search_foodnetwork(query, number)
  } else if ("pioneerwoman" == site){
    search_pioneerwoman(query, number)
  }

  else stop('No correct recipe sites entered. Supported sites include "allrecipes" and "foodnetwork".')
}



