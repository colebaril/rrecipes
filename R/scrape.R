#' @title rrecipes
#' @description Test
#' @param scrape
#' Searches recipes_url() list for website domains and conditionally passes the relevant function.
#' @return scrape
#' @import stringr
#' @examples
#' scrape(recipe_urls)

scrape <- function(recipe_urls) {

  `%rin%` <- function (pattern, list) {
    vapply(pattern, function (p) any(grepl(p, list)), logical(1L), USE.NAMES = FALSE)
  }

for (recipe_url in recipe_urls) {
  if ("allrecipes.*" %rin% recipe_urls){
    scrape_allrecipes(recipe_url)
  }
  if("foodnetwork.*" %rin% recipe_urls){
    scrape_foodnetwork(recipe_url)
  }
  if("tasty.*" %rin% recipe_urls){
    scrape_tasty(recipe_url)
  }
  if("thepioneerwoman.*" %rin% recipe_urls){
    scrape_pioneerwoman(recipe_url)
  }
}
}

