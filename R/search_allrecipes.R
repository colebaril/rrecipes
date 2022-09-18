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

  search_allrecipes <- function(search_allrecipes_query) {

    url <- 'https://www.allrecipes.com/search/results/?search='

    searchquery <- paste(url, search_allrecipes_query, sep = "")

    first_page <- read_html(searchquery)
    url_list <- first_page %>%
      html_elements("a") %>%
      html_attr("href")

    url_list <- data.frame(url_list) %>%
      filter(grepl('brownies|brownie', url_list)) %>%
      unique()

    url_list[c(1:10), ]

  }