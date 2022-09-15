#' @title rrecipes
#' @description Test
#' @param recipe_urls
#' Generates list object of recipe URLs
#' @return recipe_urlss
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringi
#' @examples
#'recipe_urls(c(
#'  "https://www.allrecipes.com/recipe/10033/iced-pumpkin-cookies/",
#'  "https://www.allrecipes.com/recipe/153245/pumpkin-spice-cupcakes/",
#'  "https://www.foodnetwork.ca/recipe/vegan-loaded-sweet-potatoes/",
#'  "https://www.foodnetwork.ca/recipe/vegan-pumpkin-waffles/")
#')
#'
#' @export

recipe_urls <- function(recipe_urls) {
  assign("recipe_urls", recipe_urls, envir=.GlobalEnv)
  recipe_urls <- list(recipe_urls)
}



