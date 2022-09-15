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
scrape_allrecipes <- function(URL) {
  recipe <- rvest::read_html(URL)

  title <- rvest::html_nodes(recipe, ".headline-wrapper") %>%
    rvest::html_text()

  ingredients <- rvest::html_nodes(recipe, ".ingredients-item-name") %>%
    rvest::html_text() %>%
    trimws()

  directions <- rvest::html_nodes(recipe, ".instructions-section-item") %>%
    rvest::html_text() %>%
    trimws()

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
