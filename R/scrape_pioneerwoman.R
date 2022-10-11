#' @title rrecipes
#' @description Test
#' @param scrape_pioneerwoman
#' Searches thepioneerwoman.com for recipes based on recipe_urls()
#' @return scrape_allrecipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export
scrape_pioneerwoman <- function(URL) {
  recipe <- rvest::read_html(URL)

  title <- rvest::html_nodes(recipe, ".exadjwu8") %>%
    rvest::html_text() %>%
    trimws()

  ingredients <- rvest::html_nodes(recipe, ".eno1xhi2") %>%
    rvest::html_text() %>%
    trimws()

  directions <- rvest::html_nodes(recipe, ".evb48wp3 .et3p2gv0") %>%
    rvest::html_text() %>%
    trimws()

  ingredients <- gsub("\\u215B", "1/8", ingredients)
  ingredients <- gsub("\\u2153", "1/3", ingredients)

  directions <- gsub(" Advertisement", "", directions)
  directions <- gsub(" {2,}", " ", directions)
  directions <- gsub("•", "", directions)
  directions <- gsub("\\.(?=[A-Za-z])", ". ", directions, perl = TRUE) # Add space after period where none is present.
  directions <- strwrap(directions)

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


