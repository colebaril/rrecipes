#' @title rrecipes
#' @description Test
#' @param search_pioneerwoman
#' Searches allrecipes.com for recipes based on recipe_urls()
#' @return search_allrecipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export

search_pioneerwoman <- function(query) {

  url <- 'https://www.thepioneerwoman.com/search/?q=' # This recently changed on the website.

  query <- gsub(" ", "+", query) # Change spaces in search query to `+` to work in URL.

  searchquery <- paste(url, query, sep = "") # Join query and base URL together.

  first_page <- rvest::read_html(searchquery) # Extract
  url_list <- first_page %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href")

  remove.list <- paste(c("/gallery/", "/article/", "/search", "tips", "video"), collapse = '|') # Specify rows to remove where these are present.
  # For this site, individual recipes are tagged as "recipes" rather than "recipe" in the URL, different from every other site thus far.

  query <- gsub("+", "-", query, fixed = TRUE) # Change `+` in query to `-` to work with recipe URL.

  url_list <- paste0('https://www.thepioneerwoman.com', url_list) # Base URL not present in HTML attributes. We add it here.

  url_list <- data.frame(url_list) %>% # Clean and format recipe list.
    filter(grepl(query, url_list)) %>%
    filter(grepl("recipes", url_list)) %>%
    filter(!grepl(remove.list, url_list)) %>%
    unique()


  url_list[c(1:10), ] # Limit results to top 10 recipes.

}


