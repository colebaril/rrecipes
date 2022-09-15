#' @title rrecipes
#' @description Test
#' @param scrape_foodnetwork
#' Searches foodnetwork.ca for recipes based on recipe_urls()
#' @return scrape_foodnetwork
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @import tidyr
#' @export
scrape_foodnetwork <- function(URL) {
  recipe <- rvest::read_html(URL)

  title <- rvest::html_nodes(recipe, ".article-title") %>%
    rvest::html_text()

  ingredientsq <- rvest::html_nodes(recipe, ".subrecipe-ingredients--quantity") %>%
    rvest::html_text() %>%
    data.table::as.data.table()

  ingredientsi <- rvest::html_nodes(recipe, ".subrecipe-ingredients--name") %>%
    rvest::html_text() %>%
    data.table::as.data.table()

  ingredients <- cbind(quantity = ingredientsq, ingredient = ingredientsi) %>%
    unite(col = Ingredients, c(quantity.., ingredient..), sep = " ")%>%
    pull(Ingredients)

  ingredients <- gsub("\\u215B", "1/8", ingredients)
  ingredients <- gsub("\\u2153", "1/3", ingredients)

  directionss <- rvest::html_nodes(recipe, ".recipe-step-content p") %>%
    rvest::html_text() %>%
    data.table::as.data.table()

  directionsn <- rvest::html_nodes(recipe, ".recipe-step-title") %>%
    rvest::html_text() %>%
    data.table::as.data.table()

  directions <- cbind(step = directionsn, directions = directionss) %>%
    unite(col = Directions, c(step.., directions..), sep = " ") %>%
    dplyr::pull(Directions)

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
