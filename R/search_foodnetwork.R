#' @title rrecipes
#' @description Test
#' @param search_foodnetwork
#' Searches foodnetwork.ca for recipes based on recipe_urls()
#' @return search_allrecipes
#' @import dplyr
#' @import rvest
#' @import data.table
#' @import stringr
#' @import magrittr
#' @export

search_foodnetwork <- function(query) {

  url <- 'https://www.foodnetwork.ca/search/' # This recently changed on the website.


  page1 <- "/?page=1"
  page2 <- "/?page=2"
  page3 <- "/?page=3"

# ----------- Bind --------------
# This section is to extract the results of the top 3 pages. It must be done in different steps
# due to how the URL links results on the page.

  # Page 1 of results
  searchquery1 <- paste(url, query, sep = "")
  searchquery1 <- paste(searchquery1, page1, sep = "")

  first_page1 <- rvest::read_html(searchquery1)
  url_list1 <- first_page1 %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href") %>%
    data.frame()

  # Page 2 of results
  searchquery2 <- paste(url, query, sep = "")
  searchquery2 <- paste(searchquery2, page2, sep = "")

  first_page2 <- rvest::read_html(searchquery2)
  url_list2 <- first_page2 %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href") %>%
    data.frame()

  # Page 3 of results
  searchquery3 <- paste(url, query, sep = "")
  searchquery3 <- paste(searchquery3, page3, sep = "")

  first_page3 <- rvest::read_html(searchquery3)
  url_list3 <- first_page3 %>%
    rvest::html_elements("a") %>%
    rvest::html_attr("href")  %>%
    data.frame()

  # ----------- Bind --------------

url_list <- rbind(url_list1, url_list2, url_list3) %>%
    as.data.frame()

names(url_list) <- "url_list"

remove.list <- paste(c("tag", "article", "/search/"), collapse = '|')

url_list <- url_list %>%
  filter(!grepl(remove.list, url_list) & grepl(query, url_list)) %>%
  unique()


  url_list[c(1:10), ]

}


