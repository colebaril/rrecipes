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

  title <- rvest::html_nodes(recipe, "#article-heading_1-0") %>%
    rvest::html_text() %>%
    trimws()

  ingredients <- rvest::html_nodes(recipe, "#mntl-structured-ingredients_1-0 p") %>%
    rvest::html_text() %>%
    trimws()

  directions <- rvest::html_nodes(recipe, "#mntl-sc-block_2-0 .mntl-sc-block-startgroup") %>%
    rvest::html_text() %>%
    trimws()

  ingredients <- gsub("\\u215B", "1/8", ingredients)
  ingredients <- gsub("\\u2153", "1/3", ingredients)

  directions <- gsub(" Advertisement", "", directions)
  directions <- gsub(" {2,}", " ", directions)
  directions <- stringr::str_trim(directions, "right")
  directions <- stringr::str_replace_all(directions, "[\r\n]" , "")
  
  sep <- '--'

  print(title)
  print(ingredients)
  print(directions)
  print(sep)

  utils::write.table(c(title, ingredients, directions, sep),
                     file = "scraped_recipes.txt",
                     append = TRUE,
                     row.names = FALSE,
                     fileEncoding = "UTF-8",
                     quote = FALSE,
                     col.names = FALSE)
}
