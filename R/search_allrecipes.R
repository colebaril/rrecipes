#' @title rrecipes
#' @description Test
#' @param search_allrecipes
#' Searches allrecipes.com for recipes based on recipe_urls()
#' @return search_allrecipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export

search_allrecipes <- function(query) {

  url <- 'https://www.allrecipes.com/search?q=' # This recently changed on the website. 

  searchquery <- paste(url, query, sep = "")

  first_page <- rvest::read_html(searchquery)
  url_list <- first_page %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href")

  remove.list <- paste(c("/recipes/", "/gallery/"), collapse = '|')

  url_list <- data.frame(url_list) %>%
    filter(grepl(query, url_list)) %>%
    filter(!grepl(remove.list, url_list)) %>%
    unique()

  url_list[c(1:10), ]

}
