#' @title rrecipes
#' @description Test
#' @param scrape_allrecipes
#' Searches allrecipes.com for recipes based on recipe_urls()
#' @return scrape_allrecipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export
scrape_tasty <- function(URL) {
  recipe <- rvest::read_html(URL)

  title <- rvest::html_nodes(recipe, ".md-mb1") %>%
    rvest::html_text()

  ingredients <- rvest::html_nodes(recipe, ".xs-mb1.xs-mt0") %>%
    rvest::html_text() %>%
    trimws() %>%
    unique()

  directions <- rvest::html_nodes(recipe, ".xs-text-3 .xs-mb2") %>%
    rvest::html_text() %>%
    trimws() %>%
    unique

  ingredients <- gsub("\\u215B", "1/8", ingredients)
  ingredients <- gsub("\\u2153", "1/3", ingredients)

  directions <- gsub(" Advertisement", "", directions)
  directions <- gsub(" {2,}", " ", directions)
  directions <- stringr::str_trim(directions, "right")

  print(title)
  print(ingredients)
  print(directions)

  utils::write.table(c(title, ingredients, directions),
                     file = "scraped_recipes.txt",
                     append = TRUE,
                     row.names = FALSE,
                     fileEncoding = "UTF-8",
                     quote = FALSE,
                     col.names = FALSE)
}
